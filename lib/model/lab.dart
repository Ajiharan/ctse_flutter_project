import 'package:cloud_firestore/cloud_firestore.dart';

class Lab{

  String title;
  String description;
  String id;
  final DocumentReference reference;

  Lab.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        title = map['title'],
        description = map['description'];

  Lab.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference:snapshot.reference);

  @override
  String toString() => "lab<$id:$title:$description>";
}