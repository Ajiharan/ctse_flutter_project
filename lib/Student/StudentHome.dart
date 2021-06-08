import 'package:ctse/Login/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BodyContainer.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CTSE MODULE PAGE',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _signOut(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 15.0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Student'),
              accountEmail: Text('Student@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Text('CSK'),
              ),
            ),
            ListTile(
              title: Text('Inbox'),
              leading: Icon(Icons.email),
            ),
            Divider(
              height: 1.0,
            ),
            ListTile(
              title: Text('settings'),
              leading: Icon(Icons.settings),
            ),
            Divider(
              height: 1.0,
            ),
          ],
        ),
      ),
      body: BodyContainer(),
    );
  }
}
