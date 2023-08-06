import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as e;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pacific_gym/models/account.dart';
import 'package:pacific_gym/models/branch.dart';
import 'package:pacific_gym/models/employee.dart';
import 'package:pacific_gym/models/member.dart';
import 'package:pacific_gym/models/product.dart';
import 'package:pacific_gym/services/firebase_auth_helper.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String? userEmail = FirebaseAuth.instance.currentUser == null
      ? "UndefinedEmail"
      : FirebaseAuth.instance.currentUser!.email;
  String? userName = FirebaseAuth.instance.currentUser?.displayName ?? "Name";

  Future<void> addUser(String name, String email, String password,
      DateTime date, BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(email);
    users.doc("profile").set({
      'name': name.trim(),
      'email': email.trim(),
      'joining_date': date
    }).then((value) {
      print("User Added");
      users.doc("data").set({"data": "true"});
    }).catchError((error) => print("Failed to add User."));

    return FirebaseFirestore.instance
        .collection("Tokens")
        .add({"email": email, "token": Utils().encryptAES(password)});
  }

  void addNewMember(String name, int age, String address, String number,
      int amount, DateTime date, String duration, DateTime expiring_at) async {
    Member member = Member(
        name: name,
        age: age,
        address: address,
        phone_number: number,
        amount: amount,
        admission_date: date,
        duration: duration,
        expiring_at: expiring_at);

    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final docref = db
        .collection(userEmail!)
        .doc("data")
        .collection("Members")
        .withConverter(
            fromFirestore: Member.fromFirestore,
            toFirestore: (Member member, options) => member.toFirestore());

    await docref.add(member);
  }

  void deleteMember(String id) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    await db
        .collection(userEmail!)
        .doc("data")
        .collection("Members")
        .doc(id)
        .delete();
  }

  void updateMember(
      String id,
      String name,
      int age,
      String address,
      String number,
      int amount,
      DateTime date,
      String duration,
      DateTime expiring_at) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final docref = db
        .collection(userEmail!)
        .doc("data")
        .collection("Members")
        .doc(id)
        .update({
      "name": name,
      "age": age,
      "address": address,
      "phone_number": number,
      "amount": amount,
      "admission_date": date,
      "duration": duration,
      "expiring_at": expiring_at
    });
    docref.then((value) => print("DocumentSnapshot successfully updated!"));
  }

  Future<Stream<List<Member>>> membersStream() async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    return db
        .collection(userEmail!)
        .doc("data")
        .collection("Members")
        .orderBy("expiring_at")
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Member> retVal = [];
      for (var element in query.docs) {
        Member member = Member.fromFirestore(element, SnapshotOptions());
        member.id = element.id;
        retVal.add(member);
      }
      // print(retVal);
      return retVal;
    });
  }
}

class BusinessService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? userEmail = FirebaseAuth.instance.currentUser == null
      ? "UndefinedEmail"
      : FirebaseAuth.instance.currentUser!.email;

  void addNewEmployee(String name, DateTime date, int amount) async {
    Employee employee = Employee(name: name, date: date, amount: amount);

    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final docref = db
        .collection(userEmail!)
        .doc("data")
        .collection("Employees")
        .withConverter(
            fromFirestore: Employee.fromFirestore,
            toFirestore: (Employee employee, options) =>
                employee.toFirestore());

    await docref.add(employee);
  }

  Future<void> deleteEmployee(String id) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    await db
        .collection(userEmail!)
        .doc("data")
        .collection("Employees")
        .doc(id)
        .delete();
  }

  // void addEmployeeSalary(int salary, DateTime date, String id) async {
  //   if (userEmail == null || userEmail == "UndefinedEmail") {
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     userEmail = sharedPreferences.getString("logged_in");
  //   }
  //   List<dynamic> lst = [
  //     {"date": date, "salary": salary}
  //   ];
  //   await db
  //       .collection(userEmail!)
  //       .doc("data")
  //       .collection("Employees")
  //       .doc(id)
  //       .update({"transactions": FieldValue.arrayUnion(lst)});
  // }

  // Future<void> deleteSalaryTransactions(String id) async {
  //   if (userEmail == null || userEmail == "UndefinedEmail") {
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     userEmail = sharedPreferences.getString("logged_in");
  //   }

  //   await db
  //       .collection(userEmail!)
  //       .doc("data")
  //       .collection("Employees")
  //       .doc(id)
  //       .update({"transactions": FieldValue.delete()});
  // }

  Future<Stream<List<Employee>>> employeeStream() async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    return db
        .collection(userEmail!)
        .doc("data")
        .collection("Employees")
        .orderBy("date", descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Employee> retVal = [];
      for (var element in query.docs) {
        Employee employee = Employee.fromFirestore(element, SnapshotOptions());
        employee.id = element.id;
        retVal.add(employee);
      }
      print(retVal);
      return retVal;
    });
  }
}

class ProductService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? userEmail = FirebaseAuth.instance.currentUser == null
      ? "UndefinedEmail"
      : FirebaseAuth.instance.currentUser!.email;

  void addNewProduct(String name, int count) async {
    Product product = Product(name: name, count: count);

    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final docref = db
        .collection(userEmail!)
        .doc("data")
        .collection("Products")
        .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, options) => product.toFirestore());

    await docref.add(product);
  }

  void updateProduct(String id, Product product) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final docref = db
        .collection(userEmail!)
        .doc("data")
        .collection("Products")
        .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, options) => product.toFirestore());

    await docref.doc(product.id).update({"count": product.count});
  }

  Future<void> deleteProduct(String id) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }

    final ref = await db
        .collection(userEmail!)
        .doc("data")
        .collection("Products")
        .doc(id)
        .delete();
  }

  Future<Stream<List<Product>>> productsStream() async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    return db
        .collection(userEmail!)
        .doc("data")
        .collection("Products")
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Product> retVal = [];
      for (var element in query.docs) {
        Product product = Product.fromFirestore(element, SnapshotOptions());
        product.id = element.id;
        retVal.add(product);
      }
      // print(retVal);
      return retVal;
    });
  }
}

class BranchService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? userEmail = FirebaseAuth.instance.currentUser == null
      ? "UndefinedEmail"
      : FirebaseAuth.instance.currentUser!.email;

  Future<bool> addNewBranch(
      String name, String address, String email, String password) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final ref = await db.collection("Tokens").get();

    for (var element in ref.docs) {
      if (element['email'] == email &&
          element['token'] == Utils().encryptAES(password)) {
        log("Verified");
        Branch branch = Branch(name: name, address: address, email: email);

        final docref = db
            .collection(userEmail!)
            .doc("data")
            .collection("Branches")
            .withConverter(
                fromFirestore: Branch.fromFirestore,
                toFirestore: (Branch branch, options) => branch.toFirestore());

        await docref.add(branch);
        return true;
      }
    }
    return false;
  }

  Future<void> deleteBranch(String id) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }

    final ref = await db
        .collection(userEmail!)
        .doc("data")
        .collection("Branches")
        .doc(id)
        .delete();
  }

  Future<List<Member>> getMembers(String email) async {
    final ref =
        await db.collection(email).doc("data").collection("Members").get();

    List<Member> retVal = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> element in ref.docs) {
      Member member = Member.fromFirestore(element, SnapshotOptions());
      member.id = element.id;
      retVal.add(member);
    }
    return retVal;
  }

  Future<List<QueryDocumentSnapshot<Product>>> getProducts(String email) async {
    final ref = await db
        .collection(email)
        .doc("data")
        .collection("Products")
        .withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, options) => product.toFirestore())
        .get();

    return ref.docs;
  }

  Future<Stream<List<Branch>>> branchsStream() async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    return db
        .collection(userEmail!)
        .doc("data")
        .collection("Branches")
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Branch> retVal = [];
      for (var element in query.docs) {
        Branch branch = Branch.fromFirestore(element, SnapshotOptions());
        branch.id = element.id;
        retVal.add(branch);
      }
      // print(retVal);
      return retVal;
    });
  }
}

class AccountsService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? userEmail = FirebaseAuth.instance.currentUser == null
      ? "UndefinedEmail"
      : FirebaseAuth.instance.currentUser!.email;

  Future<void> addNewExpense(DateTime dateTime, String collectionType,
      String expenseType, int amount) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    final docref = db
        .collection(userEmail!)
        .doc("data")
        .collection("Accounts")
        .withConverter(
            fromFirestore: Expense.fromFirestore,
            toFirestore: (Expense expense, options) => expense.toFirestore());

    switch (collectionType) {
      case "Morning":
        {
          bool exists = false;
          await docref
              .doc(dateTime.toString())
              .get()
              .then((value) => exists = value.exists);
          if (exists) {
            (await docref.doc(dateTime.toString()).update({
              "morningCollection": FieldValue.increment(
                  expenseType == "Deposit" ? amount : (amount * -1))
            }));
          } else {
            Expense expense = Expense(
                date: dateTime,
                morningCollection:
                    expenseType == "Deposit" ? amount : (amount * -1),
                eveningCollection: 0);
            await docref.doc(dateTime.toString()).set(expense);
          }

          break;
        }
      case "Evening":
        {
          bool exists = false;
          await docref
              .doc(dateTime.toString())
              .get()
              .then((value) => exists = value.exists);
          if (exists) {
            (await docref.doc(dateTime.toString()).update({
              "eveningCollection": FieldValue.increment(
                  expenseType == "Deposit" ? amount : (amount * -1))
            }));
          } else {
            Expense expense = Expense(
                date: dateTime,
                morningCollection: 0,
                eveningCollection:
                    expenseType == "Deposit" ? amount : (amount * -1));
            await docref.doc(dateTime.toString()).set(expense);
          }
          break;
        }
      default:
    }
  }

  Future<void> deleteExpense(String id) async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }

    final ref = await db
        .collection(userEmail!)
        .doc("data")
        .collection("Accounts")
        .doc(id)
        .delete();
  }

  Future<Stream<List<Expense>>> expensesStream() async {
    if (userEmail == null || userEmail == "UndefinedEmail") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userEmail = sharedPreferences.getString("logged_in");
    }
    return db
        .collection(userEmail!)
        .doc("data")
        .collection("Accounts")
        .orderBy("date", descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Expense> retVal = [];
      for (var element in query.docs) {
        Expense expense = Expense.fromFirestore(element, SnapshotOptions());
        expense.id = element.id;
        retVal.add(expense);
      }
      // print(retVal);
      return retVal;
    });
  }
}
