// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String? id;
  String name;
  DateTime date;
  int amount;

  Employee({
    this.id,
    required this.name,
    required this.date,
    required this.amount,
  });

  factory Employee.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Employee(
      name: data?['name'],
      date: data?['date'].toDate(),
      amount: data?['amount'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "date": date,
      "amount": amount,
    };
  }
}
