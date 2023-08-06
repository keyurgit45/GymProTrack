import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/consts.dart';

class SalaryTile extends StatelessWidget {
  SalaryTile({Key? key, required this.info}) : super(key: key);

  Map<String, dynamic> info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 10.0),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              backgroundColor: Color(0xFFF6F6F6),
              child: Text(
                "₹",
                style: TextStyle(fontSize: 21, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date : ${info["date"].toDate().day}/${info["date"].toDate().month}/${info["date"].toDate().year}",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Amount : ${info["salary"]} Rs.',
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                  )
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
