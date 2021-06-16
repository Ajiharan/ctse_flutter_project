
//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ViewAnnouncements extends StatefulWidget {
  @override
  _ViewAnnouncementsState createState() => _ViewAnnouncementsState();
}

class _ViewAnnouncementsState extends State<ViewAnnouncements> {
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void saveAnnouncement(){
    Map <String, dynamic> announcementData = {"id":id.text, "title":title.text, "description":description.text};
    FirebaseFirestore.instance.collection("announcements").add(announcementData).catchError((e){
      print(e.toString());
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon:Icon(Icons.search, color:Colors.black),
              onPressed: (){
              }
          ),
          IconButton(icon: Icon(Icons.add, color:Colors.black),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        scrollable: true,
                        title: Text("Create Announcement"),
                        content:Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: id,
                                  keyboardType : TextInputType.text,
                                  validator: (val){
                                    if(val == null || val.isEmpty)
                                      return "Please enter an id";
                                    else{ return null; }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.grey),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    hintText: "Id",
                                    hintStyle: TextStyle(color: Color(0xFFB3B1B1), fontSize: 15),
                                  ),
                                ),
                                SizedBox(height:16),
                                TextFormField(
                                  controller: title,
                                  keyboardType : TextInputType.text,
                                  validator: (val){
                                    if(val == null || val.isEmpty)
                                      return "Please enter a title";
                                    else{ return null; }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.grey),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    hintText: "Title",
                                    hintStyle: TextStyle(color: Color(0xFFB3B1B1), fontSize: 15),
                                  ),
                                ),
                                SizedBox(height:16),
                                TextFormField(
                                  controller: description,
                                  keyboardType : TextInputType.multiline,
                                  validator: (val){
                                    if(val == null || val.isEmpty)
                                      return "Please enter a description";
                                    else{ return null; }
                                  },
                                  textInputAction:TextInputAction.newline,
                                  minLines: 1,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.grey),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    hintText: "Description",
                                    hintStyle: TextStyle(color: Color(0xFFB3B1B1), fontSize: 15),
                                  ),
                                ),
                                SizedBox(height:16),
                                GestureDetector(
                                  onTap: (){
                                    if(_formKey.currentState.validate()) {
                                      saveAnnouncement();
                                    }
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Lecture details saved!", style: TextStyle(fontSize: 15, color:Colors.indigo),)
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.deepOrange,
                                    ),
                                    child: Text("Save", style: TextStyle(color:Colors.white, fontSize: 19),),

                                  ),
                                ),
                                SizedBox(height:16),
                                GestureDetector(
                                  onTap: (){
                                    _formKey.currentState.reset();
                                    id.clear();
                                    title.clear();
                                    description.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.orange,
                                    ),
                                    child: Text("Reset", style: TextStyle(color:Colors.white, fontSize: 19),),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),);
                    }
                );
              }
          )
        ],
        //title: Text("Admin Dashboard"),
      ),
      drawer: appDrawer(context),
      body : StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("announcements").orderBy("id", descending: true).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Text("No Announcements");
          }
          return ListView(
              children:
                snapshot.data.docs.map((document){
                  return Center(
                    child: Container(
                      margin : EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            side: BorderSide(width:0.5, color:Colors.black),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal:16, vertical:15),
                            child: Column(
                              children: [
                                Text(document['title'], style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height : 12),
                                Text(document['description'], style : TextStyle(fontSize: 15)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[
                                    IconButton(icon:Icon(Icons.edit, color:Colors.green,),
                                      onPressed: (){

                                  }),
                                    SizedBox(width:8.0),
                                    IconButton(icon:Icon(Icons.delete, color:Colors.red),
                                        onPressed: (){

                                        }),

                          ],
                                )
                      ],
                            ),
                          ),
                        ),
                  ),
                  );
                }).toList(),
            );
        }
      )

    );
  }
}
