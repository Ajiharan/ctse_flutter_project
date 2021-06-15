import 'package:ctse/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ViewLectures extends StatefulWidget {
  @override
  _ViewLecturesState createState() => _ViewLecturesState();
}

class _ViewLecturesState extends State<ViewLectures> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void saveLecture() {
    Map<String, dynamic> lectureData = {
      "title": title.text,
      "description": description.text
    };
    FirebaseFirestore.instance.collection("lectures").add(lectureData);
  }

  //Upload pdf
//single file path when file picker picks one file.
  late Map<String, String> _paths; //when file picker picks multiple files
  late String _extension;
  late FileType _pickType;
  bool _mulitiPick = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<firebase_storage.UploadTask> _tasks = [];

  openFileExplorer() async {
    try {} on PlatformException catch (e) {
      print("Unsupported operation!" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        scrollable: true,
                        title: Text("Create Lecture"),
                        content: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: title,
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return "Please enter a title";
                                    else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: "Title",
                                    hintStyle: TextStyle(
                                        color: Color(0xFFB3B1B1), fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: description,
                                  keyboardType: TextInputType.multiline,
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return "Please enter a description";
                                    else {
                                      return null;
                                    }
                                  },
                                  textInputAction: TextInputAction.newline,
                                  minLines: 1,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: "Description",
                                    hintStyle: TextStyle(
                                        color: Color(0xFFB3B1B1), fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () {
                                    openFileExplorer();
                                  },
                                  child: TextFormField(
                                    textInputAction: TextInputAction.newline,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      hintText: "Upload PDF",
                                      hintStyle: TextStyle(
                                          color: Color(0xFFB3B1B1),
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      saveLecture();
                                      _formKey.currentState!.reset();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.deepOrange,
                                    ),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                    ),
                                  ),
                                ),
                                /*RaisedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:Text("CREATE", style: TextStyle(color:Colors.orangeAccent, fontSize: 15))
                        ),*/
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              })
        ],
        //title: Text("Admin Dashboard"),
      ),
      drawer: appDrawer(context),
    );
  }
}

class CreateLecture extends StatefulWidget {
  @override
  _CreateLectureState createState() => _CreateLectureState();
}

class _CreateLectureState extends State<CreateLecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(),
      ),
    );
  }
}
