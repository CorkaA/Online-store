import 'package:flutter/material.dart';
import 'package:online_store/views/category_grid_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Интернет-магазин',
      theme: ThemeData (
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 227, 199),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 238, 156, 50),
        ),
      ),
      home: CategoryGridPage(),
    );
  }
}
