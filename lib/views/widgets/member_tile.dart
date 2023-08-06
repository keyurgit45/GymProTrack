import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/models/member.dart';

class MemberTile extends StatelessWidget {
  MemberTile({Key? key, required this.member}) : super(key: key);
  final Member member;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        padding: const EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.93,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${member.admission_date.day}-${member.admission_date.month}-${member.admission_date.year} (${member.duration})",
                      style: GoogleFonts.poppins(
                          color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.expiring_at.difference(DateTime.now()).inDays >= 0
                        ? "Expires in"
                        : "Expired ",
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  member.expiring_at.difference(DateTime.now()).inDays >= 0
                      ? Text(
                          "${member.expiring_at.difference(DateTime.now()).inDays} Days",
                          style: GoogleFonts.poppins(
                              color: Colors.greenAccent.shade700, fontSize: 16),
                          textAlign: TextAlign.end,
                        )
                      : Text(
                          "${member.expiring_at.difference(DateTime.now()).inDays * -1} Days",
                          style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.end,
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
