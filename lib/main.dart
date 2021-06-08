import 'package:ctse/Home/HomeScreen.dart';
import 'package:ctse/colorConstraint.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      builder: EasyLoading.init(),
    );
  }
}
