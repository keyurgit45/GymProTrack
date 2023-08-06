import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/models/member.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/pages/view_member_page.dart';
import 'package:pacific_gym/views/widgets/member_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.email}) : super(key: key);
  final String? email;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  late Future resultsLoaded;
  List<QueryDocumentSnapshot<Member>> _allMembers = [];
  List<QueryDocumentSnapshot<Member>> _membersList = [];

  @override
  void initState() {
    controller.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getAllMembers(widget.email!);
  }

  void _onSearchChanged() {
    log(controller.text);
    searchMembers();
  }

  void searchMembers() {
    List<QueryDocumentSnapshot<Member>> showResults = [];

    if (controller.text.isNotEmpty) {
      for (QueryDocumentSnapshot<Member> member in _allMembers) {
        if (member.data().name.trim().split(" ").length == 1 &&
            member
                .data()
                .name
                .trim()
                .split(" ")[0]
                .toLowerCase()
                .startsWith(controller.text.toLowerCase())) {
          showResults.add(member);
        } else if (member.data().name.trim().split(" ").length == 2 &&
            (member
                    .data()
                    .name
                    .trim()
                    .split(" ")[0]
                    .toLowerCase()
                    .startsWith(controller.text.toLowerCase()) ||
                member
                    .data()
                    .name
                    .trim()
                    .split(" ")[1]
                    .toLowerCase()
                    .startsWith(controller.text.toLowerCase()))) {
          showResults.add(member);
        } else if (member.data().name.trim().split(" ").length == 3 &&
            (member
                    .data()
                    .name
                    .trim()
                    .split(" ")[0]
                    .toLowerCase()
                    .startsWith(controller.text.toLowerCase()) ||
                member
                    .data()
                    .name
                    .trim()
                    .split(" ")[2]
                    .toLowerCase()
                    .startsWith(controller.text.toLowerCase()))) {
          showResults.add(member);
        }
      }
    } else {
      showResults = List.from(_allMembers);
    }
    setState(() {
      _membersList = showResults;
    });
  }

  getAllMembers(String? email) async {
    QuerySnapshot<Member> data = await DatabaseService()
        .db
        .collection(email!)
        .doc("data")
        .collection("Members")
        .withConverter(
            fromFirestore: Member.fromFirestore,
            toFirestore: (Member member, options) => member.toFirestore())
        .get();

    setState(() {
      _allMembers = data.docs;
    });
    searchMembers();
    return "complete";
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 30.0),
                        child: Icon(
                          Icons.close,
                          size: 35,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Search Members',
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, right: 20.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'Search here...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: _membersList.isEmpty
                ? const Center(
                    child: Text(
                      "No search Found",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _membersList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewMemberPage(
                                        member: _membersList[index].data(),
                                        id: _membersList[index].id,
                                        isExpired: false,
                                      )));
                            },
                            child: MemberTile(
                                member: _membersList[index].data()))),
          ),
        ],
      ),
    );
  }
}
