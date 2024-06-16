import 'dart:async';

import 'package:notepad_app/base/base_model.dart';
import 'package:notepad_app/data/model/notepad_model.dart';
import 'package:notepad_app/data/model/status_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotepadDatabase {
  static final NotepadDatabase instance = NotepadDatabase._init();

  NotepadDatabase._init();

  static Database? _database;

  factory NotepadDatabase() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notepad.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await _dropNotesTable(db);
    _dropStatusTable(db);
    await _createStatusTable(db);
    await _createNotesTable(db);
  }

  Future<void> _createStatusTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableStatus (
        ${StatusFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${StatusFields.status} TEXT NOT NULL,
        ${StatusFields.createdAt} TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createNotesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableNotes (
        ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${NoteFields.isImportant} BOOLEAN NOT NULL,
        ${NoteFields.number} INTEGER NOT NULL, 
        ${NoteFields.title} TEXT NOT NULL, 
        ${NoteFields.description} TEXT NOT NULL, 
        ${NoteFields.createdTime} TEXT NOT NULL,
        ${NoteFields.statusId} INTEGER,
        FOREIGN KEY(${NoteFields.statusId}) REFERENCES $tableStatus (${StatusFields.id}) ON DELETE CASCADE
      );
    ''');
  }

  Future<void> _dropNotesTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $tableStatus');
  }

  Future<void> _dropStatusTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $tableNotes');
  }

  Future<void> insertStatus(StatusModel status) async {
    // final status = status;
    final db = await database;
    await db.insert(tableStatus, status.toJson());
  }

  final status1 =
      StatusModel(status: 'In-progress', createdTime: DateTime.now());
  final status2 = StatusModel(status: 'Completed', createdTime: DateTime.now());

  Future<void> addData() async {
    await insertStatus(status1);
    await insertStatus(status2);
  }

  Future<void> init() async {
    await addData();
  }
}
