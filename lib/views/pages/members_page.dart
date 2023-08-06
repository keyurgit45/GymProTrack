import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/controllers/member_controller.dart';
import 'package:pacific_gym/models/member.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/services/firebase_auth_helper.dart';
import 'package:pacific_gym/views/pages/search_page.dart';
import 'package:pacific_gym/views/pages/view_member_page.dart';
import 'package:pacific_gym/views/widgets/member_tile.dart';

class MembersPage extends StatefulWidget {
  MembersPage({Key? key}) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // final members = Get.put(MemberController());
  TextEditingController controller = TextEditingController();
  final String? userEmail = DatabaseService().userEmail;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Color(0xFFF3F3F3),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/launcher.jpg"),
                )),
            title: Text(
              'Pacific GYM',
              style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(
                    child: Text(
                  "Active Members",
                  style: GoogleFonts.rubik(fontSize: 15, color: Colors.black),
                )),
                Tab(
                    child: Text("Expired Membership",
                        style: GoogleFonts.rubik(
                            fontSize: 15, color: Colors.black))),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  AuthHelper().logOut(context);
                  // Get.delete();
                },
                child: const Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: TabBarView(controller: tabController, children: [
            GetX<AuthController>(
                init: AuthController(),
                builder: (AuthController members) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchPage(
                                      email: userEmail,
                                    )));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width / 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset.zero,
                                    color: Colors.grey.withOpacity(0.5))
                              ],
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    height:
                                        MediaQuery.of(context).size.width / 10,
                                    child: const Center(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Search here...',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: members.memberList
                                .where((val) =>
                                    val.expiring_at
                                        .difference(DateTime.now())
                                        .inDays >=
                                    0)
                                .length,
                            itemBuilder: (context, index) {
                              print(members.memberList.length);
                              return Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewMemberPage(
                                                    member: members.memberList
                                                        .where((val) =>
                                                            val.expiring_at
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inDays >=
                                                            0)
                                                        .elementAt(index),
                                                    id: members.memberList
                                                        .where((val) =>
                                                            val.expiring_at
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inDays >=
                                                            0)
                                                        .elementAt(index)
                                                        .id!,
                                                    isExpired: false,
                                                  )));
                                    },
                                    child: MemberTile(
                                      member: members.memberList
                                          .where((val) =>
                                              val.expiring_at
                                                  .difference(DateTime.now())
                                                  .inDays >=
                                              0)
                                          .elementAt(index),
                                    )),
                              );
                            }),
                      ),
                    ],
                  );
                }),
            GetX<AuthController>(
                init: Get.put<AuthController>(AuthController()),
                builder: (AuthController members) {
                  if (members.memberList
                      .where((val) =>
                          val.expiring_at.difference(DateTime.now()).inDays < 0)
                      .isEmpty) {
                    return Center(
                      child: Text(
                        "No Members with Expired Membership!",
                        style: GoogleFonts.rubik(
                            fontSize: 25, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: members.memberList
                          .where((val) =>
                              val.expiring_at
                                  .difference(DateTime.now())
                                  .inDays <
                              0)
                          .length,
                      itemBuilder: (context, index) {
                        // print(members.memberList[index].name);
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ViewMemberPage(
                                          member: members.memberList
                                              .where((val) =>
                                                  val.expiring_at
                                                      .difference(
                                                          DateTime.now())
                                                      .inDays <
                                                  0)
                                              .elementAt(index),
                                          id: members.memberList
                                              .where((val) =>
                                                  val.expiring_at
                                                      .difference(
                                                          DateTime.now())
                                                      .inDays <
                                                  0)
                                              .elementAt(index)
                                              .id!,
                                          isExpired: true,
                                        )));
                              },
                              child: MemberTile(
                                member: members.memberList
                                    .where((val) =>
                                        val.expiring_at
                                            .difference(DateTime.now())
                                            .inDays <
                                        0)
                                    .elementAt(index),
                              )),
                        );
                      });
                }),
          ])),
    );
  }
}
