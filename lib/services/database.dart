import 'package:auth_with_bloc/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "registration.db"),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const boolType = "BOOLEAN DEFAULT FALSE";
    const intType = "INTEGER";
    const textType = "TEXT";

    await db.execute('''
    CREATE TABLE ${UserField.tableName} (
      ${UserField.id} $idType,
      ${UserField.username} $textType,
      ${UserField.password} $textType
    ) 
    ''');
  }

  Future<void> newUser(User newUser) async {
    final db = await database;

    await db!.insert("users", newUser.toJson());

  }

  Future<dynamic> getUser() async {
    final db = await database;
    var res = await db!.query("users");
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res[res.length];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }

  Future<List<User>> users() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db!.query("users");

    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]["id"],
        username: maps[index]["username"],
        password: maps[index]["password"],
      );
    });
  }
}
