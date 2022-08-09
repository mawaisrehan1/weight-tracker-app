import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../model/user_model.dart';
import '../utils/print_utils.dart';


class AuthProvider extends ChangeNotifier{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if(user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }


  Stream<User?>? get user{
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  // Login user...!
  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    auth.UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    PrintUtils.printValue('Login User Credential', credential.user);
    PrintUtils.printValue('Successful','User Registered Successfully');
    return _userFromFirebase(credential.user);

  }


  // Register user...!
  Future<User?> createUserWithEmailAndPassword(String name, String email, String password) async{
    auth.UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    newUserAdded(name, email, password);
    PrintUtils.printValue('Register User Credential', credential.user);
    PrintUtils.printValue('Successful','User Registered Successfully');
    return _userFromFirebase(credential.user);

  }



  // User logout...!
  Future<void> signOut()async{
    return await _firebaseAuth.signOut();

  }



  Future<void> newUserAdded(String name, String email, String password) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
    return users
        .doc('ABC123')
        .set({
      'name': name,
      'email': email,
      'password': password,
    })
        .then((value) => PrintUtils.printValue('Successful', 'User Added'))
        .catchError(
            (error) => PrintUtils.printValue('Failed to add user', '$error'));
  }


  Future<void> addWeight(String weight,) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
    return user
        .doc('ABC1234')
        .set({
      'weight': weight,
    })

        .then((value) => PrintUtils.printValue('Successful', 'User Added weight'))
        .catchError(
            (error) => PrintUtils.printValue('Failed to add user weight', '$error'));
  }





}