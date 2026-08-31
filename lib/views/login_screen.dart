import 'package:flutter/material.dart';

import 'home_screen.dart';

class EmployeeLoginScreen extends StatefulWidget {
  const EmployeeLoginScreen({super.key});

  @override
  State<EmployeeLoginScreen> createState() => _EmployeeLoginScreenState();
}

class _EmployeeLoginScreenState extends State<EmployeeLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _employeeIdController =
  TextEditingController();

  final TextEditingController _passwordController =
  TextEditingController();

  bool _isPasswordVisible = false;

  // Custom Colors
  static const Color primaryGreen = Color(0xFF017240);
  static const Color fieldBorderColor = Color(0xFFE0E0E0);
  static const Color hintColor = Colors.grey;

  @override
  void dispose() {
    _employeeIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const EmployeeHomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: primaryGreen,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ---------------------------------------------------------
                // LOGO
                // ---------------------------------------------------------
                const SizedBox(height: 40),

                _buildLogo(),

                const SizedBox(height: 40),

                // ---------------------------------------------------------
                // LOGIN CARD
                // ---------------------------------------------------------
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? size.width * 0.9 : 450,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // -------------------------------------------------
                          // TITLE
                          // -------------------------------------------------
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              color: primaryGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // -------------------------------------------------
                          // SUBTITLE
                          // -------------------------------------------------
                          const Text(
                            'Sign in to access your assigned\n'
                                'collection tasks.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // -------------------------------------------------
                          // EMPLOYEE ID
                          // -------------------------------------------------
                          _buildLabel('Employee ID'),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _employeeIdController,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(
                              hintText: 'Enter Your Employee ID',
                              prefixIcon: Icons.badge,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your Employee ID';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // -------------------------------------------------
                          // PASSWORD
                          // -------------------------------------------------
                          _buildLabel('Password'),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleLogin(),
                            decoration: _inputDecoration(
                              hintText: '********',
                              prefixIcon: Icons.lock,
                              isPassword: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 32),

                          // -------------------------------------------------
                          // LOGIN BUTTON
                          // -------------------------------------------------
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // LOGO
  // ---------------------------------------------------------
  Widget _buildLogo() {
    return Image.asset(
      'assets/G.png',
      height: 100,
      width: 100,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'G',
              style: TextStyle(
                color: primaryGreen,
                fontSize: 60,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------
  // LABEL
  // ---------------------------------------------------------
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // INPUT DECORATION
  // ---------------------------------------------------------
  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: hintColor,
        fontSize: 14,
      ),

      prefixIcon: Icon(
        prefixIcon,
        color: primaryGreen,
        size: 20,
      ),

      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(
          _isPasswordVisible
              ? Icons.visibility
              : Icons.visibility_off,
          color: hintColor,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      )
          : null,

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: fieldBorderColor,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: fieldBorderColor,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: primaryGreen,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
    );
  }
}