import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Set a consistent height
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFEDFC),
            const Color(0xFFF0F1FF),
            const Color(0xFFFFE9FD),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent, // let gradient show through
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFD60059),
          unselectedItemColor: Colors.black54,

          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ), // Fixed size
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ), // Consistent size
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/navigation_bar/home.png'),
                width: 24,
                height: 24,
              ),
              activeIcon: Image(
                image: AssetImage(
                  'assets/images/navigation_bar/home_active.png',
                ),
                width: 24,
                height: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/navigation_bar/game.png'),
                width: 24,
                height: 24,
              ),
              activeIcon: Image(
                image: AssetImage('assets/images/navigation_bar/game(1).png'),
                width: 24,
                height: 24,
              ),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/navigation_bar/qa.png'),
                width: 24,
                height: 24,
              ),
              activeIcon: Image(
                image: AssetImage('assets/images/navigation_bar/qa(1).png'),
                width: 24,
                height: 24,
              ),
              label: 'Q&A',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/navigation_bar/history.png'),
                width: 24,
                height: 24,
              ),
              activeIcon: Image(
                image: AssetImage(
                  'assets/images/navigation_bar/history(1).png',
                ),
                width: 24,
                height: 24,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/navigation_bar/user.png'),
                width: 24,
                height: 24,
              ),
              activeIcon: Image(
                image: AssetImage('assets/images/navigation_bar/user (1).png'),
                width: 24,
                height: 24,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
