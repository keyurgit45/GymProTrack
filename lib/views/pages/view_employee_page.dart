// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pacific_gym/consts/consts.dart';
// import 'package:pacific_gym/controllers/auth_controller.dart';
// import 'package:pacific_gym/controllers/employee_controller.dart';
// import 'package:pacific_gym/models/employee.dart';
// import 'package:pacific_gym/utils/utils.dart';
// import 'package:pacific_gym/views/widgets/add_employee_transaction.dart';
// import 'package:pacific_gym/views/widgets/salary_tile.dart';

// class ViewEmployee extends StatelessWidget {
//   ViewEmployee({Key? key, required this.employee, required this.index})
//       : super(key: key);
//   final Employee employee;
//   int index;
//   final controller = Get.find<AuthController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (context) => AddTransaction(id: employee.id!));
//         },
//         icon: Icon(Icons.add),
//         label: Text("ADD"),
//       ),
//       body: SafeArea(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             color: Color(0xFFFFFFFF),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     Navigator.pop(context);
//                   },
//                   child: Padding(
//                       padding: const EdgeInsets.only(top: 30.0, left: 30.0),
//                       child: Icon(
//                         Icons.close,
//                         size: 30,
//                       )),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     if (controller.employees[index].id != null) {
//                       Alert(context: context).alert(
//                           () => controller
//                               .deleteSalary(controller.employees[index].id!),
//                           () {});
//                     }
//                   },
//                   child: Padding(
//                       padding: const EdgeInsets.only(top: 30.0, right: 30.0),
//                       child: Icon(
//                         Icons.delete,
//                         size: 25,
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               color: Color(0xFFFFFFFF),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 30.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name : ${employee.name}",
//                       style: GoogleFonts.poppins(
//                           color: Color(0xFF1A1B4B),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 19),
//                     ),
//                     Text(
//                       "Address : ${employee.address}",
//                       style: GoogleFonts.poppins(
//                           color: Color(0xFF1A1B4B),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 19),
//                     ),
//                     Text(
//                       "Phone : ${employee.number}",
//                       style: GoogleFonts.poppins(
//                           color: Color(0xFF1A1B4B),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 19),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xFFF6F6F6),
//             ),
//             height: MediaQuery.of(context).size.height * 0.67,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 19.0, top: 15.0, bottom: 17.0),
//                       child: Text(
//                         'Recent Transactions',
//                         style: GoogleFonts.barlow(
//                             color: Color(0xFF1A1B4B),
//                             fontSize: 21,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                     child: Obx(
//                   () => ListView.builder(
//                       itemCount:
//                           controller.employees[index].transactions?.length ?? 0,
//                       itemBuilder: (context, ind) {
//                         controller.employees[index].transactions?.sort((a, b) =>
//                             b['date'].toDate().compareTo(a['date'].toDate()));
//                         Map<String, dynamic> map =
//                             controller.employees[index].transactions?[ind];

//                         return Padding(
//                           padding: const EdgeInsets.only(
//                               left: 15.0, right: 15.0, top: 5),
//                           child: SalaryTile(info: map),
//                         );
//                       }),
//                 ))
//               ],
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }
