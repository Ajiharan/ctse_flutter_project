import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'LectureData.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("modules").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return LectureData(
                      id: data.id,
                      description: data['description'],
                      lecture: data['lecture']);
                },
              );
      },
    );
  }
}
