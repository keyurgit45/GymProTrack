import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/pages/search_page.dart';
import 'package:pacific_gym/views/pages/view_member_page.dart';
import 'package:pacific_gym/views/widgets/member_tile.dart';

import '../../models/member.dart';

class ListMembers extends StatelessWidget {
  ListMembers({Key? key, required this.members, required this.userEmail})
      : super(key: key);
  List<Member> members;

  final String? userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                        child: Icon(
                          Icons.close,
                          size: 35,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "View All Members",
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 20.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
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
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          height: MediaQuery.of(context).size.width / 10,
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
                  itemCount: members.length,
                  itemBuilder: (conext, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewMemberPage(
                                  member: members.elementAt(index),
                                  id: members.elementAt(index).id!,
                                  isExpired: members
                                              .elementAt(index)
                                              .expiring_at
                                              .difference(DateTime.now())
                                              .inDays >=
                                          0
                                      ? false
                                      : true,
                                )));
                      },
                      child: MemberTile(
                        member: members.elementAt(index),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
