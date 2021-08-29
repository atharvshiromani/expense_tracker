import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/classes/expcategory.dart';
import 'package:expense_tracker/classes/expense_details.dart';

import 'package:flutter/material.dart';

class Authenticator {
  FirebaseAuth authenticator;
  FirebaseFirestore db;

  Authenticator(this.authenticator, this.db);

  Stream<User?> get authStateChanges => authenticator.authStateChanges();

  Future<User?> getCurrentUser() async {
    User? currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser = user!;
    });
    return currentUser;
  }

  Future<String> signIn(String email, String password) async {
    try {
      await authenticator.signInWithEmailAndPassword(
          email: email, password: password);

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await authenticator.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  Future<String> addTxtoDB(
      String category, String expenseName, int amt, DateTime day) async {
    Expense expense = Expense(category, expenseName, day, amt);
    ExpCategory expcat = ExpCategory(category, amt);
    String? uid = '';
    uid = authenticator.currentUser?.uid;

    try {
      await db
          .collection('userTxdata')
          .doc(uid)
          .collection('Transactions')
          .add(expense.toJson());

      await db
          .collection('userTxdata')
          .doc(uid)
          .collection('Category')
          .add(expcat.toJson());

      return "Successful";
    } on Exception catch (e) {
      return "Something went wrong";
    }
  }

  Stream<QuerySnapshot> fromDB(BuildContext context, String docType) async* {
    final uid = authenticator.currentUser!.uid;
    yield* FirebaseFirestore.instance
        .collection('userTxdata')
        .doc(uid)
        .collection(docType)
        .snapshots();
  }

  Future<String> signOut() async {
    try {
      await authenticator.signOut();
      return 'Signed out';
    } on Exception catch (e) {
      return "Something went wrong";
    }
  }
}
