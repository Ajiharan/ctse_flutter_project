import 'package:ctse/colorConstraint.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LectureData extends StatefulWidget {
  final String id;
  final String description;
  final String lecture;
  const LectureData(
      {Key? key,
      required this.id,
      required this.description,
      required this.lecture})
      : super(key: key);

  @override
  _LectureDataState createState() => _LectureDataState();
}

class _LectureDataState extends State<LectureData> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: HexColor('#ff5252')))),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: HexColor('#ffcdd2'),
                  border: Border(
                      left: BorderSide(width: 8, color: HexColor('#ff867f')))),
              child: Text(
                'CTSE LECTURE',
                style: TextStyle(
                  color: HexColor('#ffffff'),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                widget.lecture,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: HexColor('#ffcdd2'),
                  border: Border(
                      left: BorderSide(width: 8, color: HexColor('#ff867f')))),
              child: Text(
                'Description',
                style: TextStyle(
                  color: HexColor('#ffffff'),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                widget.description,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
