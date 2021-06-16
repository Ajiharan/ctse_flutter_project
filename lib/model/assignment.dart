import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment{

  String title;
  String description;
  String id;
  final DocumentReference reference;

  Assignment.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        title = map['title'],
        description = map['description'];

  Assignment.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference:snapshot.reference);

  @override
  String toString() => "assignment<$id:$title:$description>";
}