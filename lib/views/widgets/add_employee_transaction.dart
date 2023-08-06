import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/widgets/textfield.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime date = DateTime.now();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: MediaQuery.of(context).viewInsets,
      child: Container(
        margin: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            AmountTextField(
              controller,
            ),
            SizedBox(
              height: 20,
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
                "  ${date.day}/${date.month}/${date.year}  ",
                style: GoogleFonts.rubik(fontSize: 21),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade700,
                elevation: 0.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  try {
                    // BusinessService().addEmployeeSalary(
                    //     int.parse(controller.text), date, widget.id);
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
                  primary: Colors.blue.shade700,
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 0.79, 50)),
            )
          ],
        ),
      ),
    );
  }
}
