class Package {
  String? id;
  String title;
  String lecturer;
  String room;
  String schedule;

  Package({
    required this.title,
    required this.lecturer,
    required this.room,
    required this.schedule,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'lecturer': lecturer,
      'room': room,
      'schedule': schedule,
    };
  }

  Package copyWith({
    String? id,
    String? title,
    String? lecturer,
    String? room,
    String? schedule,
    String? newUserId,
    List<String>? userId,
  }) {
    return Package(
      id: id ?? this.id,
      title: title ?? this.title,
      lecturer: lecturer ?? this.lecturer,
      room: room ?? this.room,
      schedule: schedule ?? this.schedule,
    );
  }

  factory Package.fromMap(Map<String, dynamic> data, {String? id}) {
    return Package(
      id: id,
      title: data['title'] as String,
      lecturer: data['lecturer'] as String,
      room: data['room'] as String,
      schedule: data['schedule'] as String,
    );
  }

  @override
  String toString() {
    return 'Package{'
        'title: "$title", '
        'lecturer: "$lecturer", '
        'room: "$room", '
        'schedule: "$schedule", '
        'id: "$id"'
        '}';
  }
}
