class TeacherModel {
  static String nameClass ='teachers';
  final int id;
  final String name;

  TeacherModel({this.id = -1, required this.name});

  TeacherModel copyWith({int? id, String? name}) {
    return TeacherModel(name: name ?? this.name, id: id ?? this.id);
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(name: map["name"], id: map["id"]);
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name};
}
