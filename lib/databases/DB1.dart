import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DB1 {

  static final _db1Name = 'Favorite.db';
  static final _db1Ver = 1;
  static final _db1TableName = 'MyTable';


  static final columnID = "_id";
  static final columnNAME = "_name";
  //singleton
  DB1._privateConstructor();
  static final DB1 instance = DB1._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if(_database!=null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _db1Name);
    return await openDatabase(path, version: _db1Ver, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int ver){
    db.execute(
      '''
      CREATE TABLE $_db1TableName (
      $columnID INTEGER PRIMARY KEY,
      $columnNAME TEXT NOT NULL)
      '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_db1TableName, row);
  }

  Future <List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_db1TableName);
  }

  Future<int> update(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id = row[columnID];
    return await db.update(_db1TableName, row, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_db1TableName, where:  '$columnID =?', whereArgs:  [id]);
  }
}
