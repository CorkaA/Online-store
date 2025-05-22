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
      theme: ThemeData (primarySwatch: Colors.blue),
      home: CategoryGridPage(),
    );
  }
}
