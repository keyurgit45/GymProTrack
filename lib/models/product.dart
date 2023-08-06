import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String name;
  int count;

  Product({required this.name, required this.count});

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      name: data?['name'],
      count: data?['count'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {"name": name, "count": count};
  }
}
