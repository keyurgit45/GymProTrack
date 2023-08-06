import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/models/branch.dart';
import 'package:pacific_gym/models/member.dart';
import 'package:pacific_gym/models/product.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/widgets/list_members.dart';

class ViewBranchPage extends StatelessWidget {
  ViewBranchPage({Key? key, required this.branch}) : super(key: key);
  Branch branch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
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
                      branch.name,
                      style:
                          GoogleFonts.rubik(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils().snackBar(context, branch.email.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 20.0),
                      child: Icon(
                        Icons.email,
                        size: 25,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: BranchService().getMembers(branch.email),
                builder: (context, AsyncSnapshot<List<Member>> snapshot) {
                  // print(snapshot.data);
                  if (snapshot.hasData) {
                    int active = 0;
                    int total = snapshot.data!.length;
                    for (Member element in snapshot.data!) {
                      if (element.expiring_at
                              .difference(DateTime.now())
                              .inDays >=
                          0) {
                        active++;
                      }
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListMembers(
                                          members: snapshot.data!,
                                          userEmail: branch.email.toString(),
                                        ))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Active Members\n",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "$active",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListMembers(
                                          members: snapshot.data!,
                                          userEmail: branch.email.toString(),
                                        ))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Members\n",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "$total",
                                      style: TextStyle(
                                          fontSize: 25,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                }),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(
                "Shop",
                style: GoogleFonts.rubik(fontSize: 23, color: Colors.black),
              ),
            ),
            FutureBuilder(
                future: BranchService().getProducts(branch.email),
                builder: (context,
                    AsyncSnapshot<List<QueryDocumentSnapshot<Product>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 15.0),
                            child: ListTile(
                              tileColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              title: Text(
                                snapshot.data![index].data().name,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              subtitle: Text(
                                "No of items : ${snapshot.data![index].data().count}",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          );
                        });
                  }
                  return CircularProgressIndicator();
                })
          ]),
        ),
      ),
    );
  }
}
