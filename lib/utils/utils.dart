import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

class Utils {
  void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String encryptAES(plainText) {
    var output = sha256.convert(utf8.encode(plainText)).toString();
    return output;
  }
}

class Alert {
  BuildContext context;
  Alert({required this.context});

  void alert(Function yes, Function no) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Are you sure?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true), // passing true
                child: Text('Yes'),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        yes();
      } else {
        no();
      }
    });
  }
}
