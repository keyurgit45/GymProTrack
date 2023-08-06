import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/controllers/product_controller.dart';
import 'package:pacific_gym/models/product.dart';
import 'package:pacific_gym/services/db.dart';

class ProductTile extends StatefulWidget {
  ProductTile({Key? key, required this.product, required this.index})
      : super(key: key);
  Product product;
  int index;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final controller = Get.find<AuthController>();
  late TextEditingController _countController;
  late int initialval;
  bool isModified = false;
  int count = 0;

  @override
  void initState() {
    _countController =
        TextEditingController(text: widget.product.count.toString());
    count = widget.product.count;
    initialval = widget.product.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isModified ? 120 : 100,
        padding: const EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 8),
                            child: SizedBox(
                              width: 140,
                              child: Text(
                                widget.product.name,
                                // overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.rubik(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Product product =
                            //     controller.getProductByIndex(widget.index);
                            // product.count = product.count - 1;
                            // print(product.count);
                            // controller.updateProductByIndex(
                            //     widget.index, product);
                            setState(() {
                              count--;
                              _countController.value =
                                  TextEditingValue(text: count.toString());
                              if (initialval != count) {
                                isModified = true;
                              } else {
                                isModified = false;
                              }
                            });
                          },
                          child: const CircleAvatar(
                            backgroundColor: const Color(0xFFF6F6F6),
                            child: Icon(
                              Icons.remove,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 30,
                            child: TextFormField(
                              // initialValue: controller
                              //     .getProductByIndex(widget.index)
                              //     .count
                              //     .toString(),
                              onFieldSubmitted: (value) {
                                Product product = widget.product;
                                product.count = int.tryParse(value) ?? 0;
                                ProductService()
                                    .updateProduct(product.id!, product);
                                // controller.updateProductByIndex(
                                //     widget.index, product);
                              },
                              controller: _countController,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Product product =
                            //     controller.getProductByIndex(widget.index);
                            // product.count = product.count + 1;
                            // print(product.count);
                            // controller.updateProductByIndex(
                            //     widget.index, product);
                            // _countController.value = TextEditingValue(
                            //     text: product.count.toString());

                            setState(() {
                              count++;
                              _countController.value =
                                  TextEditingValue(text: count.toString());
                              if (initialval != count) {
                                isModified = true;
                              } else {
                                isModified = false;
                              }
                            });
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFFF6F6F6),
                            child: Icon(
                              Icons.add,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isModified)
              const SizedBox(
                height: 10,
              ),
            if (isModified)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, bottom: 5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 20)),
                        onPressed: () {
                          setState(() {
                            Product product = widget.product;
                            product.count = count;
                            ProductService()
                                .updateProduct(product.id!, product);
                            isModified = false;
                            initialval = count;
                          });
                          log("saved");
                        },
                        child: const Text("Save")),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
