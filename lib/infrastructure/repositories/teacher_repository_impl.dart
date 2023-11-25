import 'package:calendar_app/infrastructure/database/database_helper.dart';
import 'package:calendar_app/infrastructure/model/teacher_model.dart';

class TeacherRepositoryImpl {
  final dataBase = DataBaseHelper.instance.db;

  Future<List<TeacherModel>> getAll() async {
    final data = await dataBase.query(TeacherModel.nameClass);
    return data.map((e) => TeacherModel.fromMap(e)).toList();
  }

  Future<int> insert(TeacherModel teacher) async {
    return await dataBase.insert(TeacherModel.nameClass, {'name': teacher.name});
  }

  Future<void> update(TeacherModel teacher) async {
    await dataBase.update(TeacherModel.nameClass, teacher.toMap(), where: 'id = ?', whereArgs: [teacher.id]);
  }

  Future<void> delete(TeacherModel teacherModel) async {
    await dataBase.delete(TeacherModel.nameClass, where: 'id = ?', whereArgs: [teacherModel.id]);
  }
}
