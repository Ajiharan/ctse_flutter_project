import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture{

  String title;
  String description;
  String id;
  final DocumentReference reference;

  Lecture.fromMap(Map<String, dynamic> map, {this.reference})
    : id = map['id'],
        title = map['title'],
      description = map['description'];

  Lecture.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference:snapshot.reference);

  @override
  String toString() => "lecture<$id:$title:$description>";
}