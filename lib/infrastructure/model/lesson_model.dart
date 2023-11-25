class LessonModel {
  static String nameClass = 'lessons';
  final int id;
  final int dateStart;
  final int dateFinish;
  final int signatureId;

  LessonModel({required this.dateStart, required this.dateFinish, required this.signatureId, this.id = -1});

  LessonModel copyWith({int? id, int? dateStart, int? dateFinish, int? signatureId}) {
    return LessonModel(
        dateStart: dateStart ?? this.dateStart,
        dateFinish: dateFinish ?? this.dateFinish,
        id: id ?? this.id,
        signatureId: signatureId ?? this.signatureId);
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
        dateStart: map["dateStart"], dateFinish: map['dateFinish'], signatureId: map['signatureId'], id: map["id"]);
  }

  Map<String, dynamic> toMap() =>
      {'id': id, 'signatureId': signatureId, 'dateFinish': dateFinish, 'dateStart': dateStart};
}

