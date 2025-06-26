// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:nhameii/Components/backbutton.dart';
import 'package:nhameii/components/account_setting/account_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final _emailController = TextEditingController();
  final _passwordCotroller = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordCotroller.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

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
                        _buildInputField("Username", Icons.person, _usernameController),

                        // Email Field
                        _buildInputField("Email Address", Icons.email, _emailController),

                        // Password Field
                        _buildPasswordField(
                          "Enter your password",
                          _passwordCotroller,
                          _obscurePassword,
                          () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),

                        // Confirm Password Field
                        _buildPasswordField(
                          "Confirm password",
                          _confirmPasswordController,
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
                            onPressed: () async {
                              final email = _emailController.text.trim();
                              final password = _passwordCotroller.text.trim();
                              final confirmPassword = _confirmPasswordController.text.trim();
                              final username = _usernameController.text.trim();

                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password do not match'),));
                                return;
                              }
                              try {
                                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

                                await userCredential.user?.updateDisplayName(username);
                                await userCredential.user?.reload();

                                if (userCredential.user == null) {
                                  print("User is null after sign up");
                                  return;
                                }
                                await saveUserProfile(userCredential.user!, username);

                                Navigator.pushNamed(context, '/');
                              } on FirebaseAuthException catch (e) {
                                String message = "register failed";
                                if (e.code == 'email-already-in-use') {
                                  message = 'this email is alr used';
                                } else if (e.code == 'invalid-email') {
                                  message = 'invalid email';
                                } else if (e.code == 'weak-password') {
                                  message = 'weak pw';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
                              }
                            }
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(onPressed: _signInWithGoogle, icon: const FaIcon(
                                FontAwesomeIcons.google,
                                color: SignUpScreen.primaryColor,
                              ),)
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: SignUpScreen.primaryColor,
                              ),
                            ),
                            const CircleAvatar(
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

  Widget _buildInputField(String hint, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
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

  Widget _buildPasswordField(String hint, TextEditingController controller, bool obscure, VoidCallback toggle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
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
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      print('google sign-in error: ${e.code}');
          print("Signed in as: ${FirebaseAuth.instance.currentUser?.email}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('sign in failed: ${e.message}'),));
    }
  }

  Future<void> saveUserProfile(User user, String username) async {
    print("save: ${user.uid}");
    final usersRef = FirebaseFirestore.instance.collection('users');

    await usersRef.doc(user.uid).set({
      'username': username,
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
