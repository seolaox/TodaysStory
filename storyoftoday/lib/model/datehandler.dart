import 'package:storyoftoday/model/todolist.dart';

import 'memopad.dart';
import 'sdiary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeSdiaryDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'sdiary.db'),
      onCreate: (database, version) async {
        await database.execute(
            "create table sdiary(id integer primary key autoincrement, title text, content text, weathericon text, image blob, actiondate text, eventdate text)"); // eventdate 추가
      },
      version: 1,
    );
  }
 // ----

    Future<Database> initializeMemoPadDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'memopad.db'),
      onCreate: (database, version) async {
        await database.execute(
            "create table memopad(id integer primary key autoincrement, memo text, memoinsertdate text)");
      },
      version: 1,
    );
  }
 // ----

    Future<Database> initializeTodoListDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todolist.db'),
      onCreate: (database, version) async {
        await database.execute(
            "create table todolist(id integer primary key autoincrement, todo text, isChecked tinyint, todoinsertdate text)");
      },
      version: 1,
    );
  }

  insertSdiary(Sdiary sdiary) async {
    final Database db = await initializeSdiaryDB();
    await db.rawInsert(
        "insert into sdiary(title, content, weathericon, image, actiondate, eventdate) values (?,?,?,?,datetime('now', 'localtime'),?)", // eventdate 추가
        [
          sdiary.title,
          sdiary.content,
          sdiary.weathericon,
          sdiary.image,
          sdiary.eventdate, 
        ]);
  }
 // ----

  Future<List<Sdiary>> querySdiary() async {
    final Database db = await initializeSdiaryDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from sdiary');
    return queryResult.map((e) => Sdiary.fromMap(e)).toList();
  } // ----

  Future deleteSdiary(int id) async {
    final Database db = await initializeSdiaryDB();
    await db.rawDelete('delete from sdiary where id = ?', [id]);
  } // ----

  Future updateSdiary(Sdiary sdiary) async {
    final Database db = await initializeSdiaryDB();
    await db.rawUpdate(
        "update sdiary set title = ?, content = ?, weathericon =?, eventdate = ?, actiondate = datetime('now', 'localtime') where id = ?",
        [
          sdiary.title,
          sdiary.content,
          sdiary.weathericon,
          sdiary.eventdate,
          sdiary.id
        ]);
  } // ---

  Future updateSdiaryAll(Sdiary sdiary) async {
    final Database db = await initializeSdiaryDB();
    await db.rawUpdate(
        "update sdiary set title = ?, content = ?, weathericon = ?, image = ?, eventdate =?, actiondate = datetime('now', 'localtime') where id = ?",
        [
          sdiary.title,
          sdiary.content,
          sdiary.weathericon,
          sdiary.image,
          sdiary.eventdate,
          sdiary.id
        ]);
  } // ---

//-------------------------------------



  // Memolist 추가
  insertMemoPad(MemoPad memopad) async {
    final Database db = await initializeMemoPadDB();
    await db.rawInsert(
        "insert into memopad(memo, memoinsertdate) values (?,datetime('now', 'localtime'))",
        [memopad.memo]);
  }

  // Memolist 조회
  Future<List<MemoPad>> queryMemoPad() async {
    final Database db = await initializeMemoPadDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from memopad');
    return queryResult.map((e) => MemoPad.fromMap(e)).toList();
  }

  // Memolist 삭제
  Future deleteMemoPad(int id) async {
    final Database db = await initializeMemoPadDB();
    await db.rawDelete('delete from memopad where id = ?', [id]);
  }

  // Memolist 업데이트
  Future updateMemoPad(MemoPad memopad) async {
    final Database db = await initializeMemoPadDB();
    await db.rawUpdate(
        "update memopad set memo = ? , memoinsertdate = datetime('now', 'localtime') where id = ?",
        [
          memopad.memo,
          memopad.id
          ]);
  }




//-------------------------------------



  // Todolist 추가
  insertTodoList(TodoList todolist) async {
    final Database db = await initializeTodoListDB();
    await db.rawInsert(
  "insert into todolist(todo, isChecked, todoinsertdate) values (?, ?, datetime('now', 'localtime'))",
  [
    todolist.todo,
    todolist.isChecked,
  ]
);

  }

  // Todolist 조회
  Future<List<TodoList>> queryTodoList() async {
    final Database db = await initializeTodoListDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from todolist');
    return queryResult.map((e) => TodoList.fromMap(e)).toList();
  }

  // Todolist 삭제
  Future deleteTodoList(int id) async {
    final Database db = await initializeTodoListDB();
    await db.rawDelete('delete from todolist where id = ?', [id]);
  }

  // Todolist 업데이트
  Future updateTodoList(TodoList todolist) async {
    final Database db = await initializeTodoListDB();
    await db.rawUpdate(
      "update todolist set todo = ?, isChecked = ?, todoinsertdate = datetime('now', 'localtime') where id = ?",
      [
        todolist.todo,
        todolist.isChecked,
        todolist.id
      ]
    );

  }
} // DatabaseHandler