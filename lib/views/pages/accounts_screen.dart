import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/widgets/accounts_tile.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: Get.put<AuthController>(AuthController()),
        builder: (AuthController expenses) {
          // print(expenses.expenses);
          if (expenses.expenses.isEmpty) {
            return Center(
              child: Text(
                "No Expenses Added!",
                style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: expenses.expenses.length,
            itemBuilder: (context, index) {
              if (DateTime.now()
                          .difference(expenses.expenses[index].date)
                          .inDays >
                      300 &&
                  expenses.expenses[index].id != null) {
                expenses.deleteExpense(expenses.expenses[index].id!);
              }
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: AccountsTile(
                  date: expenses.expenses[index].date,
                  morningCollection: expenses.expenses[index].morningCollection,
                  eveningCollection: expenses.expenses[index].eveningCollection,
                ),
              );
            },
          );
        });
  }
}
