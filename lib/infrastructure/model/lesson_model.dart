
class LessonModel {
  static String nameClass = 'lessons';
  final int id;
  final int dateStart;
  final int dateFinish;
  final String name;

  LessonModel({required this.dateStart, required this.dateFinish, required this.name, this.id = -1});

  LessonModel copyWith({int? id, int? dateStart, int? dateFinish, String? name}) {
    return LessonModel(
        dateStart: dateStart ?? this.dateStart,
        dateFinish: dateFinish ?? this.dateFinish,
        id: id ?? this.id,
        name: name ?? this.name);
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(dateStart: map["dateStart"], dateFinish: map['dateFinish'], name: map['name'], id: map["id"]);
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'dateFinish': dateFinish, 'dateStart': dateStart};
}
