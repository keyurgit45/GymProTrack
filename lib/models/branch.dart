// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  String? id;
  String name;
  String address;
  String email;

  Branch({
    this.id,
    required this.name,
    required this.address,
    required this.email,
  });

  factory Branch.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Branch(
      name: data?['name'],
      address: data?['address'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "address": address,
      "email": email,
    };
  }
}
