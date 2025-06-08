import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  }); 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Games'),
            BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: 'Q&A'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
