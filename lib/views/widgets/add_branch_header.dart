import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBranchHeader extends StatelessWidget {
  const AddBranchHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0),
                  child: Icon(
                    Icons.close,
                    size: 35,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'New Branch',
                style: GoogleFonts.rubik(fontSize: 20, color: Colors.black),
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
    );
  }
}
