import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/services/firebase_auth_helper.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var name = ".";
  AuthHelper authHelper = AuthHelper();
  getName() async {
    // print(DataBaseHelper().userEmail.toString());
    await FirebaseFirestore.instance
        .collection(DatabaseService().userEmail.toString())
        .doc("profile")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get("name");
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: const BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15.0, top: 15),
          child: Text("Account Information"),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Utils().snackBar(context, "Not available..Just for UI");
                  },
                  child: SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            index == 0 ? "Edit Profile" : "Change Password",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 18.0),
                          child: Icon(Icons.arrow_right),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("logged_in");
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) => LandingPage()));
                  },
                  child: const Text("Log Out")),
              const Text("Version 1.0"),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        )
      ],
    );
  }
}
