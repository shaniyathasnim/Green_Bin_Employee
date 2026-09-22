import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/employee_model.dart';

class EmployeeProvider with ChangeNotifier {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Employee? _employee;

  bool _isLoading = false;
  bool _isNewEmployee = false;

  // Getters
  Employee? get employee => _employee;

  bool get isLoading => _isLoading;

  bool get isNewEmployee => _isNewEmployee;

  bool get isAuthenticated => _employee != null;

  static const String _employeeKey = 'current_employee';

  // Constructor
  EmployeeProvider() {
    loadEmployee();
  }

  // =========================
  // LOADING
  // =========================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // =========================
  // REGISTER
  // =========================

  Future<void> registerWithEmail({
    required String name,
    required String employeeId,
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    try {
      final String uid =
      DateTime.now().millisecondsSinceEpoch.toString();

      final Employee newEmployee = Employee(
        id: uid,
        name: name,
        employeeId: employeeId,
        email: email,
        profileImageUrl: '',
        joinedDate: DateTime.now().toString(),
      );

      // Save employee to Firestore
      await _firestore
          .collection('employees')
          .doc(uid)
          .set(newEmployee.toMap());

      // Store employee locally
      _employee = newEmployee;
      _isNewEmployee = false;

      await _saveEmployee(newEmployee);

      notifyListeners();
    } catch (e) {
      throw Exception('Registration failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  // =========================
  // LOGIN
  // =========================

  Future<void> loginWithEmail(
      String email,
      String password,
      ) async {
    _setLoading(true);

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore
          .collection('employees')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('Employee not found');
      }

      final Employee loggedInEmployee =
      Employee.fromMap(snapshot.docs.first.data());

      _employee = loggedInEmployee;

      _isNewEmployee =
          loggedInEmployee.name == null ||
              loggedInEmployee.name!.isEmpty;

      await _saveEmployee(loggedInEmployee);

      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  // =========================
  // SAVE EMPLOYEE LOCALLY
  // =========================

  Future<void> _saveEmployee(Employee employee) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      _employeeKey,
      jsonEncode(employee.toJson()),
    );
  }

  // =========================
  // LOAD EMPLOYEE
  // =========================

  Future<void> loadEmployee() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    final String? employeeData =
    prefs.getString(_employeeKey);

    if (employeeData != null) {
      try {
        _employee = Employee.fromJson(
          jsonDecode(employeeData),
        );

        _isNewEmployee =
            _employee?.name == null ||
                _employee!.name!.isEmpty;

        notifyListeners();
      } catch (e) {
        await prefs.remove(_employeeKey);
      }
    }
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.remove(_employeeKey);

    _employee = null;
    _isNewEmployee = false;

    notifyListeners();
  }
}