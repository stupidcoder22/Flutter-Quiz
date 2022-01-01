import 'package:flutter/material.dart';
import 'package:time_pass/Home.dart';
import 'package:time_pass/Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MCQ App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Splash(),
    );
  }
}
