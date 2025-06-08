import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nhameii/Components/account_button.dart';
import 'package:nhameii/Components/backbutton.dart';
import 'sign-up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const Color primaryColor = Color(0xFF3E0061);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3DFFF), Color(0xFFFDE4F8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonWidget(),
              const SizedBox(height: 20),
              const Text(
                "Welcome back! Glad to see you again!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              // Username/Email field
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: primaryColor),
                  hintText: "Username or Email",
                  hintStyle: const TextStyle(color: primaryColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 16),

              // Password field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: primaryColor),
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: primaryColor),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot?",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 24),

              // Login button
              SizedBox(
                height: 48,

                child: AccountButton(
                  text: 'Log in',
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Sign Up navigation
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: primaryColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: primaryColor),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  "Or Login with",
                  style: TextStyle(color: primaryColor),
                ),
              ),
              const SizedBox(height: 12),

              // Social Login
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(FontAwesomeIcons.google, color: primaryColor),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: primaryColor,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(FontAwesomeIcons.apple, color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
