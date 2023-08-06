import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pacific_gym/models/account.dart';
import 'package:pacific_gym/models/branch.dart';
import 'package:pacific_gym/models/employee.dart';
import 'package:pacific_gym/models/member.dart';
import 'package:pacific_gym/models/product.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/views/pages/home_page.dart';
import 'package:pacific_gym/views/pages/intro_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  final memberList = <Member>[].obs;

  // var membersSearchedList = <Member>[].obs;
  // List<Member> get membersSearched => membersSearchedList.value;

  List<Member> get members => memberList.value;
  final branchList = <Branch>[].obs;

  List<Branch> get branches => branchList.value;
  final employeeList = <Employee>[].obs;

  List<Employee> get employees => employeeList.value;
  final productList = <Product>[].obs;

  List<Product> get products => productList.value;

  final expensesList = <Expense>[].obs;

  List<Expense> get expenses => expensesList.value;

  void deleteProduct(String id) async {
    await ProductService().deleteProduct(id);
  }

  void deletBranch(String id) async {
    await BranchService().deleteBranch(id);
  }

  void deleteEmployee(String id) async {
    await BusinessService().deleteEmployee(id);
  }

  void deleteExpense(String id) async {
    await AccountsService().deleteExpense(id);
  }

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    memberList.bindStream(await DatabaseService().membersStream());
    branchList.bindStream(await BranchService().branchsStream());
    employeeList.bindStream(await BusinessService().employeeStream());
    productList.bindStream(await ProductService().productsStream());
    expensesList.bindStream(await AccountsService().expensesStream());

    super.onReady();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      memberList.bindStream(await DatabaseService().membersStream());
      branchList.bindStream(await BranchService().branchsStream());
      employeeList.bindStream(await BusinessService().employeeStream());
      productList.bindStream(await ProductService().productsStream());
      expensesList.bindStream(await AccountsService().expensesStream());

      print("CHANGES AUTH STATE");
    }

    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(() => IntroPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();
}
