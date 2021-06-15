import 'package:ctse/Home/HomeScreen.dart';
import 'package:ctse/Login/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BodyContainer.dart';
import 'StudentDrawer.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CTSE MODULE PAGE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: StudentDrawer(),
      body: BodyContainer(),
    );
  }
}
