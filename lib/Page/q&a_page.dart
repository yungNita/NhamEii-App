// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../components/navigation_bar/nav_wrapper.dart';

class QAPage extends StatelessWidget {
  const QAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 2, // Q&A tab index in your BottomNavigationBar
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 236, 236),
      ),
    );
  }

}
