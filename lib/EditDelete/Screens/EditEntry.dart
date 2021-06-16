import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ctse/EditDelete/Model/entry.dart';
import 'package:ctse/EditDelete/Provider/entryProvider.dart';

class EditEntryScreen extends StatefulWidget {
  final Entry entry;

  EditEntryScreen({this.entry});

  @override
  _EditEntryScreenState createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
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
        appBar: AppBar(title: Text('Edit Announcement Entry')),
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
                      labelText: 'Title'),
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
                      labelText: 'Description'),
                  onChanged: (String description) =>
                      entryProvider.changeDescription = description,
                  controller: entryController2,
                ),
                SizedBox(
                  height: 45,
                ),
                RaisedButton(
                  color: Colors.green,
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    entryProvider.saveEntry();
                    Navigator.of(context).pop();
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: ' Updated successfully!',
                      autoCloseDuration: Duration(seconds: 1),
                    );
                  },
                ),
                (widget.entry != null)
                    ? RaisedButton(
                        color: Colors.red,
                        child: Text('Delete',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (await confirm(context)) {
                            entryProvider.removeEntry(widget.entry.entryId);
                            Navigator.of(context).pop();
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: ' Deleted successfully!',
                              autoCloseDuration: Duration(seconds: 1),
                            );
                          }
                        },
                      )
                    : Container(),
              ],
            )));
  }
}
