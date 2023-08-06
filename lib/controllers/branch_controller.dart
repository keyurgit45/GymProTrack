// import 'package:get/get.dart';
// import 'package:pacific_gym/models/branch.dart';
// import 'package:pacific_gym/services/db.dart';

// class BranchController extends GetxController {
//   final branchList = <Branch>[].obs;

//   List<Branch> get branches => branchList.value;

//   void deletBranch(String id) async {
//     BranchService().deleteBranch(id);
//   }

//   @override
//   void onInit() async {
//     branchList.bindStream(
//         await BranchService().branchsStream()); //stream coming from firebase
//   }
// }
