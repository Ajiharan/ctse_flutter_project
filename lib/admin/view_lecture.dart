

//import 'dart:html';
import 'dart:io';

import 'package:ctse_app/model/lecture.dart';
import 'package:ctse_app/widgets/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';



class ViewLectures extends StatefulWidget {
  @override
  _ViewLecturesState createState() => _ViewLecturesState();
}

class _ViewLecturesState extends State<ViewLectures> {
  File file;
  UploadTask task;
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void saveLecture(){
    Map <String, dynamic> lectureData = {"id":id.text, "title":title.text, "description":description.text};
    FirebaseFirestore.instance.collection("lectures").add(lectureData);
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
    final destination  = 'lectures/$fileName';

    FirebaseApi.uploadFile(destination, file);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No file choosen';
    return Scaffold(
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
                        title: Text("Create Lecture"),
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
                                SizedBox(height: 16,),
                                GestureDetector(
                                  onTap: () async {
                                    await _formKey.currentState.reset();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.lightGreenAccent,
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
        stream:FirebaseFirestore.instance.collection("lectures").snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator());
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: 0,
              sortAscending: true,
              columns: [
                DataColumn(label: Text("Id")),
                DataColumn(label:Text("Title")),
                DataColumn(label: Text("Description")),
                DataColumn(label:Text("Actions"))
              ],
              rows: _buildRows(context, snapshot.data.docs),
            ),
          );
        }
    );
  }

  List<DataRow> _buildRows(BuildContext context, List<DocumentSnapshot> snapshot){
    return snapshot.map((data) => _buildRowItem(context, data)).toList();
  }

  DataRow _buildRowItem(BuildContext context, DocumentSnapshot data){
    final lecture  = Lecture.fromSnapshot(data);
    return DataRow(cells: [
      DataCell(Text(lecture.id)),
      DataCell(Text(lecture.title)),
      DataCell(Text(lecture.description)),
      DataCell(
        Row(
          children: [
            ElevatedButton(
                onPressed: (){},
                style:  ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.green),),
                child: Text("EDIT")),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: (){},
                style:  ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.red),),
                child: Text("DELETE")),
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

