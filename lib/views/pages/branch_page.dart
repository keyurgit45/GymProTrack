import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/controllers/branch_controller.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/pages/view_branch_page.dart';
import 'package:pacific_gym/views/widgets/branch_tile.dart';

class BranchPage extends StatelessWidget {
  const BranchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Branches',
          style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
        ),
      ),
      body: GetX<AuthController>(
          init: Get.put<AuthController>(AuthController()),
          builder: (AuthController branch) {
            print(branch.branches.length);
            if (branch.branches.isEmpty) {
              return Center(
                child: Text(
                  "No Branches Added!",
                  style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: branch.branches.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewBranchPage(
                                      branch: branch.branches[index])));
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
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
                                            branch.deletBranch(
                                                branch.branches[index].id!);
                                            Utils().snackBar(
                                                context, "Branch Deleted");
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
                          child: BranchTile(
                            branch: branch.branches[index],
                          ),
                        )),
                  );
                });
          }),
    );
  }
}
