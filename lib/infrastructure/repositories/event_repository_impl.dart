import 'package:calendar_app/infrastructure/database/database_helper.dart';
import 'package:calendar_app/infrastructure/model/event_model.dart';

class EventRepositoryImpl {
  final dataBase = DataBaseHelper.instance.db;

  Future<List<EventModel>> getAll() async {
    final data = await dataBase.query(EventModel.nameClass);
    return data.map((e) => EventModel.fromMap(e)).toList();
  }

  Future<int> insert(EventModel teacher) async {
    return await dataBase.insert(EventModel.nameClass, {'name': teacher.name});
  }

  Future<void> update(EventModel teacher) async {
    await dataBase.update(EventModel.nameClass, teacher.toMap(), where: 'id = ?', whereArgs: [teacher.id]);
  }

  Future<void> delete(EventModel teacherModel) async {
    await dataBase.delete(EventModel.nameClass, where: 'id = ?', whereArgs: [teacherModel.id]);
  }
}
