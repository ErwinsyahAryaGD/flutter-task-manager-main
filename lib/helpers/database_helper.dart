import 'dart:io';

import 'package:task_manager/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String tasksTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  // Task Tables
  // Id | Title | Date | Priority | Status
  // 0     ''      ''      ''         0
  // 1     ''      ''      ''         0
  // 2     ''      ''      ''         0

//Metode ini memeriksa apakah database telah diinisialisasi atau belum. Jika belum, maka database akan diinisialisasi dan kembali ke pemanggil.
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

//Metode ini menginisialisasi database dan membuat tabel task_table jika belum ada.
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/todo_list.db';
    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

//Metode ini digunakan untuk membuat tabel task_table dengan kolom-kolom yang telah ditentukan (id, title, date, priority, status).
  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tasksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)',
    );
  }

//Metode ini mengambil data dari tabel task_table dalam bentuk Map dan mengembalikannya sebagai List.
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTable);
    return result;
  }

//Metode ini mengambil data dari tabel task_table, mengonversinya ke dalam objek Task, dan mengembalikannya sebagai List.
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    return taskList;
  }

// Metode ini digunakan untuk menyisipkan data Task baru ke dalam tabel task_table.
  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(
      tasksTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      tasksTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> deleteAllTask() async {
    Database db = await this.db;
    final int result = await db.delete(tasksTable);
    return result;
  }
}
