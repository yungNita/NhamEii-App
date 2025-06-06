import 'package:flutter/material.dart';
import '../components/nav_wrapper.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 3, //current index for history page
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 219, 219),
      
      ),
    );
  }
}
