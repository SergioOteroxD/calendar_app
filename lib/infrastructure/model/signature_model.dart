class SignatureModel {
  static String nameClass = 'signatures';
  final int id;
  final String name;
  final int teacherId;

  SignatureModel({this.id = -1, required this.name, required this.teacherId});

  SignatureModel copyWith({int? id, String? name}) {
    return SignatureModel(name: name ?? this.name, id: id ?? this.id, teacherId: teacherId);
  }

  factory SignatureModel.fromMap(Map<String, dynamic> map) {
    return SignatureModel(name: map["name"], id: map["id"], teacherId: map["teacherId"]);
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'teacherId': teacherId};
}
