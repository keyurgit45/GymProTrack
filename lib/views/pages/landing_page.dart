import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_revision/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/services/firebase_auth_helper.dart';
import 'package:pacific_gym/views/pages/home_page.dart';
import 'package:pacific_gym/views/pages/intro_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // final authHelper = Provider.of<AuthHelper>(context);
    return GetBuilder<AuthController>(
        init: AuthController(),
        // stream: authHelper.onAuthStateChanged,
        builder: (controller) {
          if (controller.firebaseUser.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.firebaseUser.value!.uid == null) {
            return IntroPage();
          } else {
            return HomePage();
          }
        });
  }
}

// class MiddleWare extends StatefulWidget {
//   const MiddleWare({Key? key}) : super(key: key);

//   @override
//   State<MiddleWare> createState() => _MiddleWareState();
// }

// class _MiddleWareState extends State<MiddleWare> {
//   @override
//   void initState() {
//     super.initState();
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => HomePage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
