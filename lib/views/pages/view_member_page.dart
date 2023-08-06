import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pacific_gym/models/member.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/services/pdf_api.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class ViewMemberPage extends StatefulWidget {
  ViewMemberPage(
      {Key? key,
      required this.member,
      required this.id,
      required this.isExpired})
      : super(key: key);
  Member member;
  String id;
  bool isExpired;

  @override
  State<ViewMemberPage> createState() => _ViewMemberPageState();
}

class _ViewMemberPageState extends State<ViewMemberPage> {
  GlobalKey<FormState> key = GlobalKey();

  TextEditingController textEditingController = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController age = TextEditingController();

  TextEditingController number = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController amount = TextEditingController();

  DateTime date = DateTime.now();

  String duration = "Months";

  String durationTime = "1";

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  @override
  void initState() {
    name.text = widget.member.name;
    age.text = widget.member.age.toString();
    number.text = widget.member.phone_number.toString();
    address.text = widget.member.address;
    amount.text = widget.member.amount.toString();
    date = widget.member.admission_date;
    durationTime = widget.member.duration.split(" ")[0];
    duration = widget.member.duration.split(" ")[1];
    super.initState();
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
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, left: 30.0),
                            child: Icon(
                              Icons.close,
                              size: 35,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Member Details',
                          style: GoogleFonts.rubik(
                              fontSize: 20, color: Colors.black),
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
                                height: 15,
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
                                      "  ${date.day}/${date.month}/${date.year}  ",
                                      style: GoogleFonts.rubik(fontSize: 21),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue.shade700,
                                      elevation: 0.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    validator: (value) {
                                      if ((value?.length ?? 0) > 2) {
                                        return 'Error';
                                      } else if (!isNumeric(value)) {
                                        return 'Error';
                                      }
                                    },
                                    keyboardType: TextInputType.phone,
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
                        height: 16,
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
                              DatabaseService().updateMember(
                                  widget.id,
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
                          widget.isExpired ? "Renew Membership" : "Edit & Save",
                          style: GoogleFonts.rubik(fontSize: 23),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade700,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.82, 45)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // await _showMyDialog(widget.id);
                          Alert(context: context).alert(() {
                            DatabaseService().deleteMember(widget.id);
                            Navigator.of(context).pop();
                          }, () {});
                        },
                        child: Text(
                          "Delete",
                          style: GoogleFonts.rubik(fontSize: 23),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade700,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.82, 45)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            String validity =
                                "${durationTime.toString().trim()} $duration";
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Choose any one action."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {
                                          PDFApi().generatePDF(
                                              widget.id,
                                              name.text,
                                              age.text,
                                              address.text,
                                              number.text,
                                              amount.text,
                                              date,
                                              validity,
                                              true);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Open PDF")),
                                    ElevatedButton(
                                      onPressed: () {
                                        PDFApi().generatePDF(
                                            widget.id,
                                            name.text,
                                            age.text,
                                            address.text,
                                            number.text,
                                            amount.text,
                                            date,
                                            validity,
                                            false);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Whatsapp"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          "Generate Receipt",
                          style: GoogleFonts.rubik(fontSize: 23),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade700,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.82, 45)),
                      )
                    ],
                  ),
                ),
              )
            ]),
      )),
    );
  }

  // Future<void> _showMyDialog(String id) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Are you Sure?'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Delete'),
  //             onPressed: () {
  //               print('Confirmed');
  //               DatabaseService().deleteMember(widget.id);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
