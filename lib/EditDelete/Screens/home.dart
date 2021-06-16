import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ctse/EditDelete/Model/entry.dart';
import 'package:ctse/EditDelete/Provider/entryProvider.dart';
import 'package:ctse/EditDelete/Screens/EditEntry.dart';
import 'package:ctse/EditDelete/Screens/entry.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entryprovider = Provider.of<EntryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements List'),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.person, color: Colors.black), onPressed: () {})
        ],
      ),
      body: StreamBuilder<List<Entry>>(
          stream: entryprovider.entries,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      size: 35,
                      color: Colors.deepOrangeAccent,
                    ),
                    trailing: Icon(
                      Icons.edit,
                      size: 25,
                      color: Colors.deepOrangeAccent,
                    ),
                    title: Text(snapshot.data[index].entry),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditEntryScreen(entry: snapshot.data[index])));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EntryScreen()));
        },
      ),
    );
  }
}
