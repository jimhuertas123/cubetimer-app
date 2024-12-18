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
    );
  }

  Future<void> _onCreate(Database db, int version) async {
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
  }
}