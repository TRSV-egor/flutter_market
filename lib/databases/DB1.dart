import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DB1 {

  static final _dbName = 'Products.db';
  static final _dbVer = 1;
  static final _tableName = 'ProductsList';


  static final columnId = "_id";
  static final columnPrice = "_price";
  static final columnTitle = "_title";
  static final columnDescription = "_description";
  static final columnImageURL = "_imageURL";
  static final columnBalance = "_Balance";
  static final columnLike = "_Like";



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
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVer, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int ver){
    db.execute(
      '''
      CREATE TABLE $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnPrice INTEGER,
      $columnTitle TEXT NOT NULL,
      $columnDescription TEXT NOT NULL,
      $columnImageURL TEXT NOT NULL,
      $columnBalance INTEGER,
      $columnLike INTEGER,
      )
      '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future <List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName, where:  '$columnId =?', whereArgs:  [id]);
  }
}
