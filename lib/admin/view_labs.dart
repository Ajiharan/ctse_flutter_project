

///import 'dart:html';
import 'dart:io';

import 'package:ctse_app/model/lab.dart';
import 'package:ctse_app/widgets/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';



class ViewLabs extends StatefulWidget {
  @override
  _ViewLabsState createState() => _ViewLabsState();
}

class _ViewLabsState extends State<ViewLabs> {
  File file;
  UploadTask task;
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void saveLecture(){
    Map <String, dynamic> labData = {"id":id.text, "title":title.text, "description":description.text};
    FirebaseFirestore.instance.collection("labs").add(labData).catchError((e){
      print(e.toString());
    });
    uploadFile();
  }


  //UPLOAD PDF
  Future selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: false); //allows choosing only one file.

    if(result == null){
      return "No file has been chosen";
    }
    else{
      final path = result.files.single.path; //to get the path of the single file selected.
      setState(() => file = File(path));
    }
  }

  Future uploadFile() async {
    if(file == null) return ;

    final fileName = basename(file.path);
    final destination  = 'labs/$fileName';

    FirebaseApi.uploadFile(destination, file);
  }

  //Get file from firebase
  /*Future getFile(BuildContext context, String lectureFile) async{
    await FirebaseStorage.instance.ref()

  }*/


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No file choosen';

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
                        title: Text("Create Lab"),
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
                                    selectFile();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.orangeAccent,
                                    ),
                                    child: Text("Select File", style: TextStyle(color:Colors.white, fontSize: 17),),

                                  ),
                                ),
                                SizedBox(height : 8),
                                Text(fileName, style : TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height:8),
                                SizedBox(height:20),
                                GestureDetector(
                                  onTap: (){
                                    if(_formKey.currentState.validate()) {
                                      saveLecture();
                                    }
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Lab details saved!", style: TextStyle(fontSize: 15, color:Colors.indigo),)
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
      body: _buildBody(context),

    );
  }

  @override
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("labs").orderBy("id", descending:true).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator());
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.black),
              child: DataTable(
                sortColumnIndex: 1,
                sortAscending: true,
                columns: [
                  DataColumn(label: Text("Id")),
                  DataColumn(label:Text("Title")),
                  DataColumn(label: Text("Description")),
                  DataColumn(label:Text("Actions"))
                ],
                rows: _buildRows(context, snapshot.data.docs),
              ),
            ),
          );
        }
    );
  }

  List<DataRow> _buildRows(BuildContext context, List<DocumentSnapshot> snapshot){
    return snapshot.map((data) => _buildRowItem(context, data)).toList();
  }

  DataRow _buildRowItem(BuildContext context, DocumentSnapshot data){
    final lab  = Lab.fromSnapshot(data);

    //delete data
    showDeleteDialog(){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              // title: Text('Delete ${lecture['title']}'),
              title: Text('Delete Lab'),
              content:Text("Are you sure you want to delete? "),
              actions: [
                FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel", style:TextStyle(fontSize: 15, color:Colors.black))
                ),
                FlatButton(
                    onPressed: (){
                      FirebaseFirestore.instance.collection("labs").doc(lab.id).delete().whenComplete(() => Navigator.pop(context));
                    },
                    child: Text("Delete", style:TextStyle(fontSize: 15, color:Colors.red))
                )
              ],
            );

          }
      );

    }

    return DataRow(cells: [
      DataCell(Text(lab.id)),
      DataCell(Text(lab.title)),
      DataCell(Text(lab.description)),
      DataCell(
        Row(
          children: [
            IconButton(
              onPressed: (){

              },
              icon : Icon(Icons.edit, color:Colors.green),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed: (){
                showDeleteDialog();
              },
              icon : Icon(Icons.delete, color:Colors.red),
            ),
          ],
        ),
      )
    ]);

  }

}

class FirebaseApi {
  static UploadTask uploadFile(String destination, File file){
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch(e){
      return null;
    }
  }
}

class EditLecture extends StatefulWidget {

  @override
  _EditLectureState createState() => _EditLectureState();
}

class _EditLectureState extends State<EditLecture> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


