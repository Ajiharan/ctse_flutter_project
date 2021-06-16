import 'package:flutter/material.dart';
import 'package:ctse/EditDelete/Model/entry.dart';
import 'package:ctse/EditDelete/Service/firestore_service.dart';
import 'package:uuid/uuid.dart';

class EntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _description;
  String _entry;
  String _entryId;
  var uuid = Uuid();

  //Getters

  String get description => _description;
  String get entry => _entry;

  Stream<List<Entry>> get entries => firestoreService.getEntries();

  //Setters

  set changeDescription(String description) {
    _description = description;
    notifyListeners();
  }

  set changeEntry(String entry) {
    _entry = entry;
    notifyListeners();
  }

  //Function

  loadAll(Entry entry) {
    if (entry != null) {
      _description = entry.description;
      _entry = entry.entry;
      _entryId = entry.entryId;
    } else {
      _description = null;
      _entry = null;
      _entryId = null;
    }
  }

  saveEntry() {
    if (_entryId == null) {
      //add
      var newEntry =
          Entry(description: _description, entry: _entry, entryId: uuid.v1());
      firestoreService.setEntry(newEntry);
    } else {
      //edit
      var updateEntry =
          Entry(description: description, entry: _entry, entryId: _entryId);
      firestoreService.setEntry(updateEntry);
    }
  }

  removeEntry(String entryId) {
    firestoreService.removeEntry(entryId);
  }
}
