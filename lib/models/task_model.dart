class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status; // 0 - Incomplete, 1 - Complete

//Konstruktor ini digunakan untuk membuat objek Task baru tanpa ID.
  Task({this.title, this.date, this.priority, this.status});
//Konstruktor ini digunakan untuk membuat objek Task dengan ID. Ini berguna ketika Anda mengambil data dari database.
  Task.withId({this.id, this.title, this.date, this.priority, this.status});
//Metode ini mengonversi objek Task menjadi Map yang dapat disimpan di database.
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

//Factory constructor ini digunakan untuk membuat objek Task dari Map
//yang diambil dari database. Metode ini mengambil Map dan mengembalikan objek Task.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      priority: map['priority'],
      status: map['status'],
    );
  }
}
