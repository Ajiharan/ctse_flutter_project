class Entry {
  final String entryId;
  final String description;
  final String entry;

  Entry({this.description, this.entry, this.entryId});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        description: json['description'],
        entry: json['entry'],
        entryId: json['entryId']);
  }

  Map<String, dynamic> toMap() {
    return {'description': description, 'entry': entry, 'entryId': entryId};
  }
}
