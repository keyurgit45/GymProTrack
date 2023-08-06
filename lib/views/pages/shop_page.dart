import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/controllers/product_controller.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/widgets/product_tile.dart';

class ShopPage extends StatelessWidget {
  ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext bcontext) {
    return Scaffold(
      // backgroundColor: Color(0xFFf1f5fb),
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/launcher.jpg"),
            )),
        title: Text(
          'Shop',
          style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
        ),
      ),
      body: GetX<AuthController>(
          init: Get.put<AuthController>(AuthController()),
          builder: (AuthController controller) {
            // print(productBox.getAt(0).count);
            if (controller.products.isEmpty) {
              return Center(
                child: Text(
                  "No Products Added!",
                  style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this item?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.deleteProduct(
                                            controller.products[index].id!);
                                        Utils().snackBar(
                                            bcontext, "Product Deleted");
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("DELETE")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: ProductTile(
                        product: controller.products[index],
                        index: index,
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
