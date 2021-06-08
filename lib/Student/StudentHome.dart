import 'package:flutter/material.dart';

import 'BodyContainer.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module Page'),
        centerTitle: true,
      ),
      body: BodyContainer(),
    );
  }
}
