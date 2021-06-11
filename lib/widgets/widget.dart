import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Center(child: Image.asset("assets/images/background.jpg")),
  );
}

Widget appDrawer(BuildContext context) {
  final auth = FirebaseAuth.instance;
  return Drawer(
      child: ListView(
    children: [
      UserAccountsDrawerHeader(
        accountName: Text("Lakshi"),
        accountEmail: Text('it17073592@my.sliit.lk'),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.blueAccent
              : Colors.white,
          child: Text(
            "L",
            style: TextStyle(color: Colors.orange, fontSize: 40),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("Home"),
        onTap: () {
          Navigator.of(context).pop();
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminHomeScreen()));
        },
      ),
      ListTile(
        leading: Icon(Icons.announcement),
        title: Text("Announcements"),
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAnnouncements()));
        },
      ),
      //Divider(color: Colors.grey),
      ListTile(
        leading: Icon(Icons.description),
        title: Text("Lectures"),
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewLectures()));
        },
      ),
      //Divider(color: Colors.grey,),
      ListTile(
        leading: Icon(Icons.book),
        title: Text("Labs"),
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewLabs()));
        },
      ),
      //Divider(color: Colors.grey,),
      ListTile(
        leading: Icon(Icons.assignment),
        title: Text("Assignments"),
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAssignments()));
        },
      ),
      //Divider(color: Colors.grey,),
      ListTile(
        leading: Icon(Icons.link),
        title: Text("Submissions"),
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewSubmissions()));
        },
      ),
      //Divider(color: Colors.grey,),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
        onTap: () {
          //Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAnnouncements()));
        },
      ),
      //Divider(color: Colors.grey,),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("Log Out"),
        onTap: () {
          auth.signOut();
          // Navigator.of(context).pop();
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
        },
      ),
    ],
  ));
}

/*Widget CreatePopUp(){
  return showDialog(context: null)
}*/
