import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class AccountsTile extends StatelessWidget {
  AccountsTile(
      {Key? key,
      required this.date,
      required this.morningCollection,
      required this.eveningCollection})
      : super(key: key);
  DateTime date;
  int morningCollection;
  int eveningCollection;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 7.0),
              child: Text(
                Jiffy(date).format("dd MMMM yyyy"),
                style: GoogleFonts.rubik(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(255, 255, 255, 1)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Morning Collection :  ",
                          style: GoogleFonts.rubik(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "$morningCollection ₹",
                          style: GoogleFonts.rubik(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: morningCollection >= 0
                                  ? Color.fromARGB(255, 38, 180, 112)
                                  : Color.fromARGB(255, 205, 44, 33)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Evening Collection :  ",
                          style: GoogleFonts.rubik(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "$eveningCollection ₹",
                          style: GoogleFonts.rubik(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: eveningCollection >= 0
                                  ? Color.fromARGB(255, 38, 180, 112)
                                  : Color.fromARGB(255, 205, 44, 33)),
                        ),
                      ],
                    ),
                    Text(
                      "Total Collection :  ${morningCollection + eveningCollection} ₹",
                      style: GoogleFonts.rubik(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
