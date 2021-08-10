import 'package:flutter_vault/model/account.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//pubspec.yml


//kelass Dbhelper
class DbHelper1 {
  static DbHelper1 _dbHelper;
  static Database _database;

  DbHelper1._createObject();

  factory DbHelper1() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper1._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'account.db';

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama account
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE account (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        site TEXT,
        password TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  // Future<List<Map<String, dynamic>>>
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('account', orderBy: 'site');
    return mapList;
  }

//create databases
  Future<int> insert(Account object) async {
    Database db = await this.database;
    int count = await db.insert('account', object.toMap());
    return count;
  }
//update databases
  Future<int> update(Account object) async {
    Database db = await this.database;
    int count = await db.update('account', object.toMap(),
        where: 'id=?',
        whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('account',
        where: 'id=?',
        whereArgs: [id]);
    return count;
  }

  Future<List<Account>> getAccountList() async {
    var accountList = await select();
    int count = accountList.length;
    List<Account> contactList = [];
    for (int i=0; i<count; i++) {
      contactList.add(Account.fromMap(accountList[i]));
    }
    return contactList;
  }

}