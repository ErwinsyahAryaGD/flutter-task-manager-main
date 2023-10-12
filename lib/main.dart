import 'package:flutter/material.dart';
import 'package:task_manager/screens/splash_screen.dart';

// Fungsi main() adalah titik awal dari aplikasi Flutter. Ini menjalankan aplikasi dengan memanggil widget MyApp.
void main() {
  runApp(MyApp());
}

// Ini mendefinisikan kelas MyApp yang merupakan turunan dari StatelessWidget.
//Kelas ini adalah root widget dari aplikasi dan mengembalikan sebuah MaterialApp.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Di dalam build() method dari MyApp, sebuah widget MaterialApp dibuat. MaterialApp adalah root widget yang menyediakan struktur dasar untuk aplikasi Flutter dan digunakan untuk
    //mengonfigurasi beberapa parameter seperti judul aplikasi, tema, dan widget halaman awal.
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
