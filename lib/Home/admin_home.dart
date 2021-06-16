import 'package:ctse/EditDelete/Screens/home.dart';
import 'package:ctse/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final Categories categories = Categories();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.person, color: Colors.black), onPressed: () {})
          ],
          //title: Text("Admin Dashboard"),
        ),
        drawer: appDrawer(context),
        body: Container(child: categories));
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Admin Dashboard",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 60,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 30,
                                child: IconButton(
                                    icon: Icon(Icons.announcement,
                                        color: Colors.white, size: 35),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }),
                              ),
                              SizedBox(height: 10),
                              Text("Announcements",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewLectures()));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 60,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.pinkAccent,
                                radius: 30,
                                child: IconButton(
                                    icon: Icon(Icons.description,
                                        color: Colors.white, size: 35),
                                    onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewLectures()));
                                    }),
                              ),
                              SizedBox(height: 10),
                              Text("Lectures",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                "11",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewLabs()));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 60,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.purpleAccent,
                                radius: 30,
                                child: IconButton(
                                    icon: Icon(Icons.book,
                                        color: Colors.white, size: 35),
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ViewLabs()));
                                    }),
                              ),
                              SizedBox(height: 10),
                              Text("Labs",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                "10",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAssignments()));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 60,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 30,
                                child: IconButton(
                                    icon: Icon(Icons.assignment,
                                        color: Colors.white, size: 35),
                                    onPressed: () {
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAssignments()));
                                    }),
                              ),
                              SizedBox(height: 10),
                              Text("Assignments",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                "11",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
