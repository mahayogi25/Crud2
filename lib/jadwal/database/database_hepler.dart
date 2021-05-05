import 'dart:async';
import 'dart:io' as io;

import 'package:tugas_crud/jadwal/database/model/db.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // membuat table
    await db.execute(
        "CREATE TABLE Jadwal(id INTEGER PRIMARY KEY, mapel TEXT, jenjang TEXT, hari TEXT)");
  }

  Future<int> saveUser(JadwalDb jadwal) async {
    var dbClient = await db;
    int res = await dbClient.insert("Jadwal", jadwal.toMap());
    return res;
  }

  Future<List<JadwalDb>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Jadwal');
    List<JadwalDb> daftar = new List();
    for (int i = 0; i < list.length; i++) {
      var jadwal =
          new JadwalDb(list[i]["mapel"], list[i]["jenjang"], list[i]["hari"]);
      jadwal.setUserId(list[i]["id"]);
      daftar.add(jadwal);
    }
    print(daftar.length);
    return daftar;
  }

  Future<int> deleteUsers(JadwalDb jadwal) async {
    var dbClient = await db;

    int res =
        await dbClient.rawDelete('DELETE FROM Jadwal WHERE id = ?', [jadwal.id]);
    return res;
  }

  Future<bool> update(JadwalDb jadwal) async {
    var dbClient = await db;




    int res =   await dbClient.update("Jadwal", jadwal.toMap(),
        where: "id = ?", whereArgs: <int>[jadwal.id]);



    return res > 0 ? true : false;
  }
}
