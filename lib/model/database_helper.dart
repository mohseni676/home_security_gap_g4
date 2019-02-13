import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:home_security_gap_g4/model/device.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableDevice = 'devicesTable';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnSimNumber = 'simnumber';
  final String columnPassword='password';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    //print(databasesPath);
    String path = join(databasesPath.path, 'devices.db');

    //await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableDevice($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnSimNumber TEXT, $columnPassword TEXT)');
  }

  Future<int> saveDevice(Device device) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableDevice, device.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List<Device>> getAllDevices() async {
    var dbClient = await db;
    var result = await dbClient.query(tableDevice, columns: [columnId, columnTitle, columnSimNumber,columnPassword]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
    List<Device> ls= result.isNotEmpty? result.map((c)=>Device.fromMap(c)).toList():[];

    return ls;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableDevice'));
  }

  Future<Device> getDevice(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableDevice,
        columns: [columnId, columnTitle, columnSimNumber,columnPassword],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Device.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteDevice(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableDevice, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateDevice(Device device) async {
    var dbClient = await db;
    return await dbClient.update(tableDevice, device.toMap(), where: "$columnId = ?", whereArgs: [device.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}