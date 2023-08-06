// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pacific_gym/utils/validator.dart';

class AddressTextField extends CustomField {
  const AddressTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Address',
            obscureText: false,
            validator: Validator.username,
            keyboardType: TextInputType.streetAddress,
            controller: controller,
            maxlines: 3);
}

class AgeTextField extends CustomField {
  const AgeTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Age',
            obscureText: false,
            validator: Validator.age,
            controller: controller,
            keyboardType: TextInputType.phone);
}

class CountTextField extends CustomField {
  const CountTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Count',
            obscureText: false,
            controller: controller,
            validator: Validator.amount,
            keyboardType: TextInputType.phone);
}

class EmailTextField extends CustomField {
  const EmailTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Email',
            obscureText: false,
            controller: controller,
            keyboardType: TextInputType.emailAddress);
}

class NameTextField extends CustomField {
  const NameTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Name',
            obscureText: false,
            validator: Validator.username,
            controller: controller,
            keyboardType: TextInputType.name);
}

class PhoneTextField extends CustomField {
  const PhoneTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Phone',
            obscureText: false,
            validator: Validator.phone,
            controller: controller,
            keyboardType: TextInputType.phone);
}

class AmountTextField extends CustomField {
  const AmountTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Amount',
            obscureText: false,
            validator: Validator.amount,
            controller: controller,
            keyboardType: TextInputType.phone);
}

class PasswordTextField extends CustomField {
  const PasswordTextField(TextEditingController controller)
      : super(
            // onChanged: onChanged,
            text: 'Password',
            obscureText: true,
            controller: controller,
            keyboardType: TextInputType.visiblePassword);
}

class CustomField extends StatelessWidget {
  // final void Function(String) onChanged;
  final String? text;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  final int maxlines;

  const CustomField({
    Key? key,
    // this.onChanged,
    this.text,
    this.obscureText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.maxlines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          maxLines: maxlines,
          controller: controller,
          obscureText: obscureText!,
          validator: validator,
          textAlign: TextAlign.start,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: InputBorder.none,
            hintText: text,
            hintStyle: GoogleFonts.rubik(
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
