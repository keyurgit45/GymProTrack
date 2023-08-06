// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pacific_gym/models/product.dart';
// import 'package:pacific_gym/services/db.dart';

// class ProductController extends GetxController {
//   final productList = <Product>[].obs;

//   List<Product> get products => productList.value;

//   void deleteProduct(String id) async {
//     await ProductService().deleteProduct(id);
//   }

//   @override
//   void onInit() async {
//     productList.bindStream(
//         await ProductService().productsStream()); //stream coming from firebase
//   }
// }
