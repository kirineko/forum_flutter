
import 'package:flutter/material.dart';
import 'package:simple_forum_app/home_page.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  ThemeData(primarySwatch: Colors.blue),
      home:  HomePage(),
    );
  }
}


