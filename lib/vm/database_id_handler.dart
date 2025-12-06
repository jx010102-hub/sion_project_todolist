import 'package:path/path.dart';
import 'package:sion_project02/model/user_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseIdHandler {
  // Connection 연결
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'login_user.db'),
      onCreate: (db, version) async {
        await db.execute("""
          create table login_user
          (
          id integer primary key autoincrement,
          name text not null,
          userimages blob
          )
          """);

        await db.execute("""
          create table login_user_deleted(
          id integer primary key autoincrement,
          name text not null,
          userimages blob
          )
          """);
      },
      version: 1,
    );
  }

  // Query 검색
  Future<List<UserList>> querylogin() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> querylogin = await db
        .rawQuery('select * from login_user');
    return querylogin
        .map((e) => UserList.fromMap(e))
        .toList();
  }

  // Insert 입력
  Future<int> insertlogin(UserList userlist) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into login_user (name,userimages)
      values
      (?,?)
      """,
      [userlist.name, userlist.userimages],
    );
    return result;
  }

  // delete 삭제
  Future<void> deletelogin(int id, String name) async {
    final Database db = await initializeDB();

    await db.rawInsert(
      """
    insert into login_user_deleted
    (id, name)
    values (?,?)
    """,
      [name],
    );

    await db.rawDelete(
      "delete from login_user where id = ?",
      [id],
    );
  }
}
