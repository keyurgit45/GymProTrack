import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/widgets/add_employee_header.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  GlobalKey<FormState> key = GlobalKey();

  TextEditingController name = TextEditingController();

  TextEditingController amount = TextEditingController();

  DateTime date = DateTime.now();

  String duration = "Borrow";

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  @override
  void dispose() {
    name.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddEmployeeHeader(),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Form(
                        key: key,
                        child: Column(
                          children: [
                            NameTextField(name),
                            AmountTextField(amount)
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2100));
                            if (newDate != null) {
                              setState(() {
                                date = newDate;
                              });
                            }
                          },
                          child: Text(
                            " ${date.day}/${date.month}/${date.year} ",
                            style: GoogleFonts.rubik(fontSize: 21),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade700,
                            elevation: 0.0,
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        DropdownButton<String>(
                          value: duration,
                          items: <String>["Borrow", "Lend"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              duration = val!;
                            });
                          },
                          iconSize: 40.0,
                        ),
                      ],
                    )
                  ])),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                if (key.currentState!.validate() &&
                    name.text.isNotEmpty &&
                    amount.text.isNotEmpty) {
                  try {
                    if (duration == "Borrow") {
                      BusinessService().addNewEmployee(name.text.trim(), date,
                          int.tryParse(amount.text.trim()) ?? 0);
                    } else if (duration == "Lend") {
                      BusinessService().addNewEmployee(name.text.trim(), date,
                          ((int.tryParse(amount.text.trim()) ?? 0) * -1));
                    }
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text(
                "Add",
                style: GoogleFonts.rubik(fontSize: 23),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade700,
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 0.76, 50)),
            )
          ]),
    ))));
  }
}
