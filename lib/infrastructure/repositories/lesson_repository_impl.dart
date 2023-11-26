import 'package:calendar_app/infrastructure/database/database_helper.dart';

import '../model/lesson_model.dart';

class LessonRepositoryImpl {
  final dataBase = DataBaseHelper.instance.db;

  Future<List<LessonModel>> getAll() async {
    final data = await dataBase.query(LessonModel.nameClass);
    return data.map((e) => LessonModel.fromMap(e)).toList();
  }

  Future<int> insert(LessonModel signature) async {
    return await dataBase.insert(LessonModel.nameClass,
        {'dateFinish': signature.dateFinish, 'dateStart': signature.dateStart, 'name': signature.name});
  }

  Future<void> update(LessonModel signature) async {
    await dataBase.update(LessonModel.nameClass, signature.toMap(), where: 'id = ?', whereArgs: [signature.id]);
  }

  Future<void> delete(LessonModel lessonModel) async {
    await dataBase.delete(LessonModel.nameClass, where: 'id = ?', whereArgs: [lessonModel.id]);
  }
}
