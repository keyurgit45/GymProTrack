import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/views/pages/add_branch.dart';
import 'package:pacific_gym/views/pages/add_employee.dart';
import 'package:pacific_gym/views/pages/add_member.dart';
import 'package:pacific_gym/views/pages/branch_page.dart';
import 'package:pacific_gym/views/pages/bussiness_page.dart';
import 'package:pacific_gym/views/pages/members_page.dart';
import 'package:pacific_gym/views/pages/shop_page.dart';
import 'package:pacific_gym/views/widgets/add_product.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [MembersPage(), ShopPage(), BussinessPage(), BranchPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: index == 1
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: index == 2
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                if (index == 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddMember()));
                } else if (index == 1) {
                  showDialog(
                      context: context, builder: (context) => AddProduct());
                } else if (index == 3) {
                  showDialog(
                      context: context, builder: (context) => AddBranch());
                }
                print("ADD");
              },
              icon: Icon(Icons.add),
              label: Text("ADD"),
            ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
            onDestinationSelected: (value) => setState(() {
                  index = value;
                }),
            selectedIndex: index,
            height: 70,
            backgroundColor: Color(0xFFf1f5fb),
            destinations: [
              NavigationDestination(icon: Icon(Icons.people), label: "Members"),
              NavigationDestination(
                  icon: Icon(Icons.shopping_cart), label: "Shop"),
              NavigationDestination(
                  icon: Icon(Icons.money), label: "Bussiness"),
              NavigationDestination(icon: Icon(Icons.shop), label: "Branch"),
            ]),
      ),
      body: screens[index],
    );
  }
}
