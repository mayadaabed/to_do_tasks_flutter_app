import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
List<Map> tasks = [];

void createDatabase() async {
  database = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database, version) {
      debugPrint('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        debugPrint('table Created');
      }).catchError((e) {
        debugPrint('Erorr when creating table: ${e.toString()}');
      });
    },
    onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        tasks = value;
        debugPrint('$tasks');
      });
      debugPrint('database opened');
    },
  );
}

Future insertToDatabase({
  required String title,
  required String time,
  required String date,
}) async {
  return await database.transaction((txn) {
    return txn
        .rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES ("$title", "$date", "$time", "new")')
        .then((value) {
      debugPrint('$value Inserted Successfully');
    }).catchError((e) {
      debugPrint('Erorr when inserting new record: ${e.toString()}');
    });
  });
}

Future<List<Map>> getDataFromDatabase(database) async {
  return await database.rawQuery('SELECT * ALL FROM tasks');
}
