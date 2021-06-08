import 'package:ctse/Home/HomeScreen.dart';
import 'package:ctse/colorConstraint.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ctse-assignment',
      theme: ThemeData(
          primaryColor: PrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: HomeScreen(),
    );
  }
}
