import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/local/creat_local_db.dart';
import 'package:todo_app/data/repo/repo.dart';
import 'package:todo_app/logic/cubit/tasks_cubit.dart';
import 'package:todo_app/presenation/screens/archive-task_screen.dart';
import 'package:todo_app/presenation/screens/done_task_screen.dart';
import 'package:todo_app/presenation/screens/new_task_screen.dart';

import '../widgets/bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  //contollers
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController DateControlLer = TextEditingController();

  /// each change according to

  //keys
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
//bool

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..createDataBase(),
      child: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is TasksinsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          TasksCubit cubit = TasksCubit.get(context);
          return Scaffold(
            key: scaffoldKey, // scafold key to show bottom sheet
            appBar: AppBar(
              title: cubit.AppBarTitles[
                  cubit.currentIndex], //list of titles according to ref
            ),
            body: cubit.bodyWidgetNewOrDoneOrArchive[
                cubit.currentIndex], //list of body screen accorfing to index

            ///FLoating Action Button
            floatingActionButton: FloatingActionButton(
              child: cubit.sheetIcon,
              onPressed: () {
                if (cubit.isBottomsheetOpened) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDataBase(
                        title: titleController.text,
                        date: DateControlLer.text,
                        time: timeController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          elevation: 15,
                          (context) => myBottomSheet(
                              titleController: titleController,
                              timeController: timeController,
                              context: context,
                              formkey: formKey,
                              DateController: DateControlLer))
                      .closed
                      .then((value) {
                    titleController.clear();
                    timeController.clear();
                    DateControlLer.clear();
                    cubit.changeBottomSheetState(
                        isOpen: false, iconData: Icon(Icons.edit));
                  });

                  cubit.changeBottomSheetState(
                      isOpen: true, iconData: Icon(Icons.add));
                }
              },
            ),

            ///Bottom navigation Bar
            bottomNavigationBar: BottomNavigationBar(
                currentIndex:
                    cubit.currentIndex, // to make tab index to be current index
                onTap: (index) {
                  cubit.changeIndex(
                      index); // to make tab index to be current index
                  //   setState(() {});
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archived'),
                ]),
          );
        },
      ),
    );
  }
}
