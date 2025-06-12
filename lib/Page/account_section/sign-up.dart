// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:nhameii/Components/backbutton.dart';
import 'package:nhameii/components/account_setting/account_button.dart';

import '../../components/backbutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const primaryColor = Color(0xFF4A0072);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3DFFF), Color(0xFFFDE4F8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.arrow_back,
                        //     color: SignUpScreen.primaryColor,
                        //   ),
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                        const BackButtonWidget(),
                        const SizedBox(height: 20),
                        const Text(
                          "Hello! Register to get started!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: SignUpScreen.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Username Field
                        _buildInputField("Username", Icons.person),

                        // Email Field
                        _buildInputField("Email Address", Icons.email),

                        // Password Field
                        _buildPasswordField(
                          "Enter your password",
                          _obscurePassword,
                          () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),

                        // Confirm Password Field
                        _buildPasswordField(
                          "Confirm password",
                          _obscureConfirmPassword,
                          () => setState(
                            () =>
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Log In Button
                        SizedBox(
                          width: double.infinity,
                          child: AccountButton(
                            text: 'Sign up',
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Already have an account
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: SignUpScreen.primaryColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/log-in');
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: SignUpScreen.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Divider(color: SignUpScreen.primaryColor),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            "Or Sign Up with",
                            style: TextStyle(color: SignUpScreen.primaryColor),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Social Login Icons
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                color: SignUpScreen.primaryColor,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: SignUpScreen.primaryColor,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.apple,
                                color: SignUpScreen.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: SignUpScreen.primaryColor),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hint, bool obscure, VoidCallback toggle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.lock, color: SignUpScreen.primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: SignUpScreen.primaryColor,
            ),
            onPressed: toggle,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
