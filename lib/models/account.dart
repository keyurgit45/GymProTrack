import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String? id;
  DateTime date;
  int morningCollection;
  int eveningCollection;

  Expense(
      {this.id,
      required this.date,
      required this.morningCollection,
      required this.eveningCollection});

  factory Expense.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Expense(
      date: data?['date'].toDate(),
      morningCollection: data?['morningCollection'],
      eveningCollection: data?['eveningCollection'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": date,
      "morningCollection": morningCollection,
      "eveningCollection": eveningCollection,
    };
  }
}
