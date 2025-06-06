import 'package:flutter/material.dart';
import '../components/nav_wrapper.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 4, //current index for account page
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 241, 241),
        body: Center(
          
          ),
        ),
    );
  }
}
