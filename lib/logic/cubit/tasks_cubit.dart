import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/data/repo/repo.dart';
import 'package:todo_app/presenation/screens/new_task_screen.dart';

import '../../presenation/screens/archive-task_screen.dart';
import '../../presenation/screens/done_task_screen.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TaksInitial());
  static TasksCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool isBottomsheetOpened = false;

  List<Widget> bodyWidgetNewOrDoneOrArchive = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchiveTaskScreen(),
  ];

  List<Widget> AppBarTitles = [
    Text('New Task'),
    Text('Done Task'),
    Text('archive Task'),
  ];

  List<Map<dynamic, dynamic>> Newtasks = [];
  List<Map<dynamic, dynamic>> Donetasks = [];
  List<Map<dynamic, dynamic>> Archivedtasks = [];

  Widget sheetIcon = Icon(Icons.edit);
  late Database dataBase;

  void createDataBase() {
    openDatabase(
      'todo.db', // data base name
      version: 1, //data base version
      // create db
      onCreate: (database, version) {
        print('db created');
        database // object of db
            .execute(
                'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)') //create table
            .then((value) {
          print('table created ');
        }).catchError((error) {
          print('Error on table created ${error.toString()}');
        });
      },
      // opend data base
      onOpen: (database) {
        getDataFromDataBase(database);
        print('db opened');
      },
    ).then((value) {
      dataBase = value;
      emit(TasksCreateDataBaseState());
    });
  }

  Future insertToDataBase({
    required String title,
    required String date,
    required String time,
  }) async {
    //databas is object of cretated db
    return dataBase = await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO test(title, date, time,status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        print('$value inserted suceesfully');
        emit(TasksinsertDataBaseState());
        getDataFromDataBase(dataBase);
        print('db opened');
      }).catchError((error) {
        print('error while inserted row ${error.toString()}');
      });
      return Future.value(dataBase);
    });
  }

  void getDataFromDataBase(database) {
    Newtasks = [];
    Donetasks = [];
    Archivedtasks = [];
    database.rawQuery('SELECT * FROM Test').then((value) {
      value.forEach((Element) {
        if (Element['status'] == 'new') {
          Newtasks.add(Element);
        } else if (Element['status'] == 'Done') {
          Donetasks.add(Element);
        } else {
          Archivedtasks.add(Element);
        }
      });
      emit(TasksGetDataBaseState());
    });
  }

  void updateData({required String staus, required int id}) {
    dataBase.rawUpdate('UPDATE Test SET status = ? WHERE id = ?',
        ['$staus', id]).then((value) {});
    getDataFromDataBase(dataBase);
    emit(TasksUpdatetDataBaseState());
  }

  void DeleteData({required int id}) {
    dataBase.rawUpdate('DELETE FROM Test WHERE id = ?', [id]).then((value) {});
    getDataFromDataBase(dataBase);
    emit(TasksDeletetDataBaseState());
  }

  void changeBottomSheetState({required isOpen, required Widget iconData}) {
    isBottomsheetOpened = isOpen;
    sheetIcon = iconData;
    emit(TasksChangeBottomSheetState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(TasksAppBottomNavBarChangeState());
  }
}
