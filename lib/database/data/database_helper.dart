import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cube_timer.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    ).onError((error, stackTrace) {
      debugPrint('Error opening database: $error');
      throw Exception('Error opening database: $error');
    });
  }

  Future<void> _onCreate(Database db, int version) async {
    
    // await deleteDatabase(join(await getDatabasesPath(), 'cube_timer.db'));
    debugPrint('creating datatables!!!');
    
    await db.execute('''
      CREATE TABLE CubeType (
        id INTEGER PRIMARY KEY,
        type TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE Category (
        id INTEGER PRIMARY KEY,
        name TEXT,
        cubeTypeId INTEGER,
        FOREIGN KEY (cubeTypeId) REFERENCES CubeType(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE TimeRecord (
        id INTEGER PRIMARY KEY,
        categoryId INTEGER,
        time REAL,
        date TEXT,
        scramble TEXT,
        comment TEXT,
        FOREIGN KEY (categoryId) REFERENCES Category(id)
      )
    ''');

    await db.execute('''
      INSERT INTO CubeType (id, type) VALUES
        ${initCubeTypes.map((cubeType) => "('${cubeType.id}', '${cubeType.type.name}')").join(',')}
      ''');
    
    await db.execute('''
      INSERT INTO Category (name, cubeTypeId) VALUES
         ${initCubeTypes.map((cubeType) => "('Normal', '${cubeType.id}')").join(',')}
    ''');
  }
}
