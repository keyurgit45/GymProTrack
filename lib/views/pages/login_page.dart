import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pacific_gym/consts/consts.dart';
import 'package:pacific_gym/services/firebase_auth_helper.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthHelper authHelper = AuthHelper();

  bool isValid() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) return true;
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
            height: 25,
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
                  child: Text("Welcome Back")),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 30.0),
            child: Text(
              "Log in to your existing account.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
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
            padding: const EdgeInsets.only(left: 22.0, bottom: 40, right: 22.0),
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
                  authHelper.logIn(email.text, password.text, context);
                } else {
                  Utils()
                      .snackBar(context, "Email and Password cannot be empty.");
                }
              },
              child: const Text("Log in"),
              color: AppColors().introPageColor,
            ),
          ),
        ],
      ),
    );
  }
}
