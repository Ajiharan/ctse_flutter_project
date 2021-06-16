import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ctse/EditDelete/Model/entry.dart';
import 'package:ctse/EditDelete/Provider/entryProvider.dart';

class EntryScreen extends StatefulWidget {
  final Entry entry;

  EntryScreen({this.entry});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final entryController1 = TextEditingController();
  final entryController2 = TextEditingController();

  @override
  void dispose() {
    entryController1.dispose();
    entryController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);
    if (widget.entry != null) {
      //edit
      entryController1.text = widget.entry.entry;
      entryController2.text = widget.entry.description;
      entryProvider.loadAll(widget.entry);
    } else {
      entryProvider.loadAll(null);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Announcement Entry')),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Enter Title'),
                  onChanged: (String entryname) =>
                      entryProvider.changeEntry = entryname,
                  controller: entryController1,
                ),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Enter Description'),
                  onChanged: (String description) =>
                      entryProvider.changeDescription = description,
                  controller: entryController2,
                ),
                SizedBox(
                  height: 45,
                ),
                RaisedButton(
                  color: Colors.green,
                  child: Text('save', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    entryProvider.saveEntry();
                    Navigator.of(context).pop();
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: ' Added successfully!',
                      autoCloseDuration: Duration(seconds: 1),
                    );
                  },
                ),
              ],
            )));
  }
}
