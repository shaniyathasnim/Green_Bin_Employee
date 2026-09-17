import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee_model.dart';

class EmployeeProvider with ChangeNotifier {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Employee? employee;
  String? verificationId;
  bool _isLoading = false;
  bool _isNewemployee = false;

  Employee? get employee => _currentEmployee; ;
  bool get isLoading => _isLoading;
  bool get isNewEmployee => _isNewemployee;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // bool get isAuthenticated => _currentEmployee != null;

  // Key for local storage
  // static const String _employeeKey = 'current_employee';
  //
  //  EmployeeProvider() {
  //   loadEmployee();
   // }

  // Future<void> loadEmployee() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? employeeData = prefs.getString(_employeeKey);
  //   if (employeeData != null) {
  //     _currentEmployee = Employee.fromJson(json.decode(employeeData));
  //     notifyListeners();
  //   }
  // }

  Future<void> registerWithEmail({
    required String name,
    required String employeeId,
    required String email,
    required String password,
  }) async {
    _isLoading = true;

    try {
      log('hgggggggg');
      final String uid = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
       employee = Employee(
        id: uid,
        name: name,
        employeeId: employeeId,
        email: email,
        profileImageUrl: '',
        joinedDate: '',
      );

      await _firestore
          .collection('employees')
          .doc(uid)
          .set(employee!.toMap());
      log('aaaaaaaaa');
      _isNewemployee = false;
      notifyListeners();


    }on FirebaseAuthException catch (e) {
      log('Firebase Auth Error Code: ${e.code}');
      log('Firebase Auth Error Message: ${e.message}');
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }
// EMAIL & PASSWORD LOGIN
  Future<void> loginWithEmail(String email, String password) async {
 _setLoading(true);

     try {
final UserCredential credential = await _auth.signInWithEmailAndPassword(
email: email,
password: password,
);

final User? user = credential.user;

if (user == null) {
throw Exception('Login failed');
}
final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
.collection('customers')
.where('email', isEqualTo: email)
.limit(1)
.get();

if (snapshot.docs.isNotEmpty) {
// Customer exists
employee =Employee.fromMap(snapshot.docs.first.data());

_isNewemployee = false;
} else {
// Customer doesn't exist in Firestore
final String uid = DateTime.now().millisecondsSinceEpoch.toString();
employee = Employee(
id: uid,
name: '',
employeeId: '',
email: email,
profileImageUrl: '',
joinedDate: '',
);
await _firestore.collection('Employees').doc(uid).set(employee!.toMap());
_isNewemployee = true;
}
notifyListeners();
} catch (e) {
rethrow;
} finally {
_setLoading(false);
}
  }


  Future<void> logout() async {
    await _auth.signOut();
    _currentEmployee = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_employeeKey);
    notifyListeners();
  }
}