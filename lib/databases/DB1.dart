import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//Класс базы данных
class DatabaseHelper {

  //Параметры базы
  static final _dbName = 'Products.db';
  static final _dbVer = 1;
  static final _tableName = 'Products';

  //Параметры таблицы
  static final columnMainId = "_mainId";
  static final columnId = "id";
  static final columnPrice = "price";
  static final columnTitle = "title";
  static final columnDescription = "description";
  static final columnImageURL = "imageURL";
  static final columnBalance = "balance";

  //Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  //Асинхронные функции

  //Получение базы данных
  Future<Database> get database async {
    if(_database!=null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  //Инициализация базы данных
  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVer, onCreate: _onCreate);
  }

  //Создание таблицы
  Future _onCreate(Database db, int ver) async{
    db.execute(
      '''
      CREATE TABLE $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnPrice INTEGER,
      $columnTitle TEXT NOT NULL,
      $columnDescription TEXT NOT NULL,
      $columnImageURL TEXT NOT NULL,
      $columnBalance INTEGER
      )
      '''
    );
  }

  //Вставить запись в таблицу
  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  //Получить всё содержимое таблицы
  Future <List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  //Обновить требуемый элемент
  Future<int> update(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(_tableName, row,
        where: '$columnId = ?', whereArgs: [id]);
  }

  //Удалить требуемый элемент
  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName, where:  '$columnId =?', whereArgs:  [id]);
  }

  //Удалить все записи из таблицы
  Future<int> deleteAll() async{
    Database db = await instance.database;
    return await db.rawDelete("DELETE FROM $_tableName");
  }

  //Найти запись по ИД
  query(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id = row[columnId];
    return await db.rawQuery("SELECT $columnId FROM $_tableName WHERE $columnId = $id");
  }

}
