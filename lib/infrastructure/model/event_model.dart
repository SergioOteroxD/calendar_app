class EventModel {
  static String nameClass ='events';
  final int id;
  final String name;

  EventModel({this.id = -1, required this.name});

  EventModel copyWith({int? id, String? name}) {
    return EventModel(name: name ?? this.name, id: id ?? this.id);
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(name: map["name"], id: map["id"]);
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name};
}
