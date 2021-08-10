import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelperProvider with ChangeNotifier {
  static final tableName = 'account';
  sql.Database db;

  DBHelperProvider() {
    // this will run when provider is instantiate the first time
    init();
  }

  void init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, 'account.db'),
      onCreate: (db, version) {
        final stmt = '''CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            site TEXT,
            username, TEXT,
            password TEXT
        )'''
            .trim()
            .replaceAll(RegExp(r'[\s]{2,}'), ' ');
        return db.execute(stmt);
      },
      version: 1,
    );
    // the init funciton is async so it won't block the main thread
    // notify provider that depends on it when done
    notifyListeners();
  }

  Future<int> insert(String table, Map<String, Object> data) async {
    return await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<int> update(String table, Map<String, Object> data,
      {String where, List<Object> whereArgs}) async {
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, {String where, List<Object> whereArgs}) async {
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db.query(table);
  }
}
