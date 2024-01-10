// import 'package:sqflite/sqflite.dart';

// class LocalDB {



//   late Database database;

//   Future<Database> createDataBase() async{
//    database = await openDatabase(
//       'todo.db', // data base name
//       version: 1, //data base version
//       // create db
//       onCreate: (database, version) {
//                       print('db created');
//                       database.execute(
//                        'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)') .then((value) {
//                         print('table created ');
//                       }).catchError((error) {
//                         print('Error on table created ${error.toString()}');
//                       });

//       },
//       onOpen: (database) {
//                         getDataFromDataBase(database).then((data) {

//                           print(data);
//                         });
//                         print('db opened');
//                       },
//                     ).then((value) {
//                     });
//   }
//   // Future insertToDataBase({
//   //   required String title,
//   //   required String date,
//   //   required String time,
//   // }) async {
//   //   //databas is object of cretated db
//   //   return data = await data.transaction((txn) {
//   //     txn
//   //         .rawInsert(
//   //             'INSERT INTO test(title, date, time,status) VALUES("$title", "$date", "$time","new")')
//   //         .then((value) {
//   //       print('$value inserted suceesfully');
//   //       getDataFromDataBase(data).then((data) {

//   //         print(data);
//   //         tasks = data;
//   //       });
//   //       print('db opened');
//   //     }).catchError((error) {
//   //       print('error while inserted row ${error.toString()}');
//   //     });
//   //     return Future.value(data);
//   //   });
//   // }

//   Future <List> getDataFromDataBase(dynamic database) async {
//     return await database.rawQuery('SELECT * FROM Test');
//   }

// }