import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/models/employee.dart';

class EmployeeTile extends StatelessWidget {
  EmployeeTile({Key? key, required this.employee}) : super(key: key);
  final Employee employee;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        padding: const EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CircleAvatar(
            backgroundColor: Color(0xFFF6F6F6),
            child: Text(
              "💰",
              style: TextStyle(fontSize: 21, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                employee.amount >= 0
                    ? Text(
                        "${employee.amount} ₹ Taken",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.redAccent.shade700,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    : Text(
                        "${(employee.amount * -1)} ₹ Given",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 11, 124, 58),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                Text(
                  "Date : ${employee.date.day}/${employee.date.month}/${employee.date.year}",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
