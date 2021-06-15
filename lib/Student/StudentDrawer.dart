import 'package:ctse/Home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        elevation: 15.0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Student'),
              accountEmail: Text('Student@gmail.com'),
              currentAccountPicture: CircleAvatar(
                onBackgroundImageError: (err, e) {},
                backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/ctse-assignment-250c4.appspot.com/o/111.png?alt=media&token=7e9033cb-46a7-494a-a67c-7ab709f16438"),
              ),
            ),
            ListTile(
              title: Text('Lectures'),
              leading: Icon(Icons.assessment),
            ),
            Divider(
              height: 1.0,
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                _signOut(context);
              },
            ),
            Divider(
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
