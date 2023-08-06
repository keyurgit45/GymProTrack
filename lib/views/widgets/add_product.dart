import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/controllers/product_controller.dart';
import 'package:pacific_gym/models/product.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController countcontroller = TextEditingController();
  DateTime date = DateTime.now();

  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // insetPadding: MediaQuery.of(context).viewInsets,
      child: Container(
        margin: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            NameTextField(
              namecontroller,
            ),
            SizedBox(
              height: 15,
            ),
            CountTextField(countcontroller),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (namecontroller.text.isNotEmpty) {
                  try {
                    ProductService().addNewProduct(namecontroller.text,
                        int.tryParse(countcontroller.text) ?? 0);
                    // controller.addProduct(Product(
                    //     namecontroller.text, int.parse(countcontroller.text)));
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text(
                "Add",
                style: GoogleFonts.rubik(fontSize: 25),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade700,
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 0.79, 50)),
            )
          ],
        ),
      ),
    );
  }
}
