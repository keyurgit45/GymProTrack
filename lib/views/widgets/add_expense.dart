import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/widgets/add_member_header.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class AddExpense extends StatefulWidget {
  AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  GlobalKey<FormState> key = GlobalKey();

  TextEditingController amount = TextEditingController();

  DateTime date = DateTime.now();

  String transaction = "Deposit";

  String time = "Morning";

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.85,
        // margin: EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: key,
                  child: Column(
                    children: [
                      AmountTextField(amount),
                      SizedBox(
                        height: 10,
                      ),
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
                          "${date.day}/${date.month}/${date.year}",
                          style: GoogleFonts.rubik(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            elevation: 0.0,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.79, 45)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton<String>(
                            value: transaction,
                            items: <String>['Deposit', 'Withdraw']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                transaction = val!;
                              });
                            },
                            iconSize: 40.0,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          DropdownButton<String>(
                            value: time,
                            items: <String>['Morning', 'Evening']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                time = val!;
                              });
                            },
                            iconSize: 40.0,
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    try {
                      AccountsService().addNewExpense(
                          DateTime(date.year, date.month, date.day),
                          time,
                          transaction,
                          int.tryParse(amount.text) ?? 0);
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text(
                  "Add",
                  style: GoogleFonts.rubik(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.79, 45)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
