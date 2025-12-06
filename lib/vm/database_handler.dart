import 'package:path/path.dart';
import 'package:sion_project02/model/todo_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  // Connection 연결
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'todolist.db'),
      onCreate: (db, version) async {
        await db.execute("""
          create table todolist
          (
          id integer primary key autoincrement,
          todo text,
          initdate date,
          memo text,
          priority text,
          complete integer default 0
          )
          """);

        await db.execute("""
          create table deletelist(
          id integer primary key autoincrement,
          todo text,
          initdate date,
          memo text,
          priority text,
          complete integer default 0
          )
          """);
      },
      version: 1,
    );
  }

  // Query 검색
  Future<List<TodoList>> querytodo() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db
        .rawQuery('select * from todolist');
    return queryResults
        .map((e) => TodoList.fromMap(e))
        .toList();
  }

  //삭제 페이지 검색
  Future<List<TodoList>> querytodo2() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db
        .rawQuery('select * from deletelist');
    return queryResults
        .map((e) => TodoList.fromMap(e))
        .toList();
  }

  // Insert 입력
  Future<int> insertlist(TodoList todolist) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into todolist (todo, memo, priority, complete)
      values
      (?,?,?,?)
      """,
      [
        todolist.todo,
        todolist.memo,
        todolist.priority,
        todolist.complete ?? 0,
      ],
    );
    return result;
  }

  // Update 수정
  Future updateAction(TodoList todolist) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update todolist
      set todo = ?, memo = ?, priority = ?, complete =?
      where id = ?
      """,
      [
        todolist.todo,
        todolist.memo,
        todolist.priority,
        todolist.complete == true ? 1 : 0,
        todolist.id,
      ],
    );
    return result;
  }

  // delete 삭제

  Future<void> deletelist(
    int id,
    String todo,
    String memo,
    String priority,
    bool complete,
  ) async {
    final Database db = await initializeDB();

    await db.rawInsert(
      """
    insert into deletelist(todo, memo, priority, complete)
    values (?,?,?,?)
    """,
      [todo, memo, priority, complete ? 1 : 0],
    );

    await db.rawDelete(
      "delete from todolist where id = ?",
      [id],
    );
  }

  //삭제에서 삭제
  Future<void> deletelist2(int id) async {
    final Database db = await initializeDB();
    await db.rawDelete(
      """
      delete from deletelist
      where id = ?
      """,
      [id],
    );
  }
}
