import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/widgets/add_branch_header.dart';
import 'package:pacific_gym/views/widgets/add_member_header.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class AddBranch extends StatelessWidget {
  AddBranch({Key? key}) : super(key: key);

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddBranchHeader(),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                          child: Column(
                        children: [
                          NameTextField(name),
                          AddressTextField(address),
                          EmailTextField(email),
                          PasswordTextField(pass),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                      ElevatedButton(
                        onPressed: () async {
                          if (name.text.isNotEmpty &&
                              address.text.isNotEmpty &&
                              email.text.isNotEmpty &&
                              pass.text.isNotEmpty) {
                            try {
                              bool isVerified = await BranchService()
                                  .addNewBranch(name.text, address.text,
                                      email.text, pass.text);
                              if (!isVerified) {
                                Utils().snackBar(
                                    context, "Passwords is Incorrect");
                              } else {
                                Navigator.of(context).pop();
                              }
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
                            primary: Colors.blue,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.79, 50)),
                      )
                    ],
                  ),
                ),
              )
            ]),
      )),
    );
  }
}
