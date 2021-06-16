import 'package:ctse/EditDelete/Provider/entryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntryProvider(),
      child: MaterialApp(
          home: HomeScreen(),
          theme: ThemeData(
              accentColor: Colors.deepOrangeAccent,
              primaryColor: Colors.black)),
    );
  }
}
