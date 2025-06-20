import 'package:flutter/material.dart';
// import 'package:nhameii/Components/gradient_background.dart';
import 'package:nhameii/components/account_setting/account_button.dart';
import 'package:nhameii/components/account_setting/account_header.dart';
import 'package:nhameii/components/account_setting/account_menu_container.dart';
import 'package:nhameii/components/gradient_background.dart';

import '../../components/navigation_bar/nav_wrapper.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 300,
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Log out of your account?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E0061),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Not now",
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 91, 91),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFD4EB1), Color(0xFFD8007A)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD8007A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacementNamed(context, '/account-not-log-in');
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 4,
    child: GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 36, right: 22, left: 22),
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              
                AccountHeader(name: 'Kasibook', email: 'Kasibook@gmail.com' ),
                
                const SizedBox(height: 18),
                AccountMenuContainer(
                  children: [
                    _buildMenuItem(
                      context,
                      Icons.person_outline,
                      'Edit Profile',
                      '/edit_profile',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.history,
                      'History',
                      '/history',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.favorite_border,
                      'Wishlist',
                      '/wishlist',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.notifications_none,
                      'Notifications',
                      '/notification',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.support_outlined,
                      'FAQ',
                      '/faq',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.sticky_note_2_sharp,
                      'Term and Policy',
                      '/term-and-polocies',
                    ),
                    _buildMenuItem(
                      context,
                      Icons.phone,
                      'Contact Us',
                      '/contact-us',
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AccountButton(text: 'Log out', onPressed: () {_showLogoutDialog(context);  },),
                      
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
            )
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String routeName,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 26),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
