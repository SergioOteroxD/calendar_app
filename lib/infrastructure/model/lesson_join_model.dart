import 'package:calendar_app/dominio/share/util_event.dart';

class LessonJoinModel {
  static String nameClass = 'lessons_join';
  final DateTime dateStart;
  final DateTime dateFinish;
  final String profesor;
  final String materia;

  LessonJoinModel({required this.dateStart, required this.profesor, required this.materia, required this.dateFinish});

  LessonJoinModel copyWith({int? id, DateTime? dateStart, DateTime? dateFinish, String? profesor, String? materia}) {
    return LessonJoinModel(
        dateFinish: dateFinish ?? this.dateFinish,
        dateStart: dateStart ?? this.dateStart,
        profesor: profesor ?? this.profesor,
        materia: materia ?? this.materia);
  }

  factory LessonJoinModel.fromMap(Map<String, dynamic> map) {
    return LessonJoinModel(
        dateStart: unixToDateTime(map["dateStart"]), dateFinish: unixToDateTime(map['dateFinish']), profesor: map['profesor'], materia: map["materia"]);
  }

  Map<String, dynamic> toMap() =>
      {'profesor': profesor, 'materia': materia, 'dateFinish': dateFinish, 'dateStart': dateStart};
}
