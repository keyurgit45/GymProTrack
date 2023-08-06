import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pacific_gym/controllers/auth_controller.dart';
import 'package:pacific_gym/controllers/employee_controller.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:pacific_gym/views/pages/accounts_screen.dart';
import 'package:pacific_gym/views/pages/add_employee.dart';
import 'package:pacific_gym/views/pages/view_employee_page.dart';
import 'package:pacific_gym/views/widgets/add_expense.dart';
import 'package:pacific_gym/views/widgets/employee_tile.dart';

class BussinessPage extends StatefulWidget {
  BussinessPage({Key? key}) : super(key: key);

  @override
  State<BussinessPage> createState() => _BussinessPageState();
}

class _BussinessPageState extends State<BussinessPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // final members = Get.put(MemberController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Color(0xFFF3F3F3),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (tabController.index == 0) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEmployee()));
              } else if (tabController.index == 1) {
                showDialog(
                    context: context, builder: (context) => AddExpense());
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => AddExpense()));
              }

              print("ADD");
            },
            icon: Icon(Icons.add),
            label: Text("ADD"),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/launcher.jpg"),
                )),
            title: Text(
              'Bussiness',
              style: GoogleFonts.rubik(fontSize: 25, color: Colors.black),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(
                    child: Text(
                  "Transactions",
                  style: GoogleFonts.rubik(fontSize: 15, color: Colors.black),
                )),
                Tab(
                    child: Text("Accounts",
                        style: GoogleFonts.rubik(
                            fontSize: 15, color: Colors.black))),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              GetX<AuthController>(
                  init: Get.put<AuthController>(AuthController()),
                  builder: (AuthController employeee) {
                    print(employeee.employees.length);
                    if (employeee.employees.isEmpty) {
                      return Center(
                        child: Text(
                          "No Employees Added!",
                          style: GoogleFonts.rubik(
                              fontSize: 25, color: Colors.black),
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: employeee.employees.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: UniqueKey(),
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirm"),
                                        content: const Text(
                                            "Are you sure you wish to delete this item?"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () {
                                                employeee.deleteEmployee(
                                                    employeee
                                                        .employees[index].id!);
                                                Utils().snackBar(context,
                                                    "Transaction Deleted");
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("DELETE")),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("CANCEL"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: EmployeeTile(
                                  employee: employeee.employees[index],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
              AccountsScreen()
            ],
          )),
    );
  }
}
