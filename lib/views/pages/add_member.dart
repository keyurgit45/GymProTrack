import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/widgets/add_member_header.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class AddMember extends StatefulWidget {
  AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  GlobalKey<FormState> key = GlobalKey();

  TextEditingController name = TextEditingController();

  TextEditingController age = TextEditingController();

  TextEditingController number = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController amount = TextEditingController();

  DateTime date = DateTime.now();

  String duration = "Months";

  String durationTime = "1";

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    address.dispose();
    amount.dispose();
    number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddMemberHeader(),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
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
                              AgeTextField(age),
                              AddressTextField(address),
                              PhoneTextField(number),
                              AmountTextField(amount),
                              SizedBox(
                                height: 20,
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
                                      style: GoogleFonts.rubik(fontSize: 20),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      elevation: 0.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length > 2) {
                                        return 'Error';
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    initialValue: durationTime,
                                    onChanged: (val) {
                                      setState(() {
                                        durationTime = val;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  DropdownButton<String>(
                                    value: duration,
                                    items: <String>['Months', 'Year']
                                        .map((String value) {
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
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            try {
                              DateTime expiring_at = DateTime.now();
                              String validity =
                                  "${durationTime.toString().trim()} $duration";
                              switch (duration) {
                                case "Months":
                                  expiring_at = Jiffy(date)
                                      .add(
                                          months: (int.tryParse(
                                                  durationTime.trim()) ??
                                              0))
                                      .dateTime;
                                  if (kDebugMode) log("$expiring_at");
                                  break;
                                case "Year":
                                  expiring_at = Jiffy(date)
                                      .add(
                                          years: (int.tryParse(
                                                  durationTime.trim()) ??
                                              0))
                                      .dateTime;
                                  if (kDebugMode) log("$expiring_at");
                                  break;

                                default:
                              }
                              DatabaseService().addNewMember(
                                  name.text,
                                  int.parse(age.text),
                                  address.text,
                                  number.text,
                                  int.parse(amount.text),
                                  date,
                                  validity,
                                  expiring_at);
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
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.79, 50)),
                      )
                    ],
                  ),
                ),
              )
            ]),
      )),
    );
  }
}
