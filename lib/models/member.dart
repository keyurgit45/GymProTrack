// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String? id;
  String name;
  int age;
  String address;
  String phone_number;
  int amount;
  DateTime admission_date;
  String duration;
  DateTime expiring_at;

  Member(
      {
      // required this.number,
      required this.name,
      required this.age,
      required this.address,
      required this.phone_number,
      required this.amount,
      required this.admission_date,
      required this.duration,
      required this.expiring_at});

  factory Member.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Member(
        name: data?['name'],
        age: data?['age'],
        address: data?['address'],
        phone_number: data?['phone_number'],
        amount: data?['amount'],
        admission_date: data?['admission_date'].toDate(),
        duration: data?['duration'],
        expiring_at: data?['expiring_at'].toDate());
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "age": age,
      "address": address,
      "phone_number": phone_number,
      "amount": amount,
      "admission_date": admission_date,
      "duration": duration,
      "expiring_at": expiring_at
    };
  }
}
