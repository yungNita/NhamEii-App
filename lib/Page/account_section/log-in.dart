// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:nhameii/Components/backbutton.dart';
import 'package:nhameii/components/account_setting/account_button.dart';
import '../../components/backbutton.dart';
import 'sign-up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
  class _LoginScreenState extends State<LoginScreen> {

  static const Color primaryColor = Color(0xFF3E0061);

  final _emailController = TextEditingController();
  final _passwordCotroller = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordCotroller.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordCotroller.text.trim());
      Navigator.pushReplacementNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      String message = 'login fail';
      if (e.code == 'user-not-found') {
        message = 'no user found';
      } else if (e.code == 'wrong-password') {
        message = 'wrong password';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('google log in fail')));
    }
  }
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
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: primaryColor),
                  hintText: "Email",
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
                controller: _passwordCotroller,
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

                child: _isLoading ? const Center(child: CircularProgressIndicator(),): AccountButton(
                  text: 'Log in',
                  onPressed: _signInWithEmail,
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
                children: [
                  GestureDetector(
                    onTap: _signInWithGoogle,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.google, color: primaryColor),
                    ),
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
