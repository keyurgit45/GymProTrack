import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pacific_gym/consts/consts.dart';
import 'package:pacific_gym/utils/utils.dart';

import '../../services/firebase_auth_helper.dart';

class SignUpPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SignUpPage({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthHelper authHelper = AuthHelper();
  bool isValid() {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 2 - 165,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                  child: Text("Sign Up")),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 30.0),
            child: Text(
              "Create an account for free.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 10, right: 22.0),
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 10, right: 22.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 30, right: 22.0),
            child: TextFormField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            ),
          ),
          Center(
            child: CupertinoButton(
              onPressed: () {
                if (isValid()) {
                  authHelper.signUp(
                      name.text, email.text, password.text, context);
                } else {
                  Utils().snackBar(context, "Every field must be filled.");
                }
              },
              child: const Text("Sign Up"),
              color: AppColors().introPageColor,
            ),
          ),
        ],
      ),
    );
  }
}
