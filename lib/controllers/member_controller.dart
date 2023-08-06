// import 'package:get/get.dart';
// import 'package:pacific_gym/models/member.dart';
// import 'package:pacific_gym/services/db.dart';

// class MemberController extends GetxController {
//   final memberList = <Member>[].obs;

//   List<Member> get members => memberList.value;

//   @override
//   void onReady() async {
//     ever(memberList, (lst) => print(lst));
//     memberList.bindStream(
//         await DatabaseService().membersStream()); //stream coming from firebase
//   }
// }
