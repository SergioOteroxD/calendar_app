import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import '../model/lesson_model.dart';
import '../model/signature_model.dart';
import '../model/teacher_model.dart';

class DataBaseHelper {
  static DataBaseHelper? _dataBaseHelper;
  DataBaseHelper._internal();

  static DataBaseHelper get instance => _dataBaseHelper ??= DataBaseHelper._internal();

  Database? _db;
  Database get db => _db!;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      join(await getDatabasesPath(), 'calendar_database.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE ${TeacherModel.nameClass} (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(100));');
        db.execute(
            'CREATE TABLE ${SignatureModel.nameClass} (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(100),teacherId INTEGER,FOREIGN KEY(teacherId) REFERENCES ${TeacherModel.nameClass}(id) );');
        db.execute(
            'CREATE TABLE ${LessonModel.nameClass} (id INTEGER PRIMARY KEY AUTOINCREMENT, dateStart INTEGER, dateFinish INTEGER,signatureId INTEGER,FOREIGN KEY(signatureId) REFERENCES ${SignatureModel.nameClass}(id) );');
      },
    );
  }
}
