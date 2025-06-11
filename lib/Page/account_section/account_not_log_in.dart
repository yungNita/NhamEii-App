import 'package:flutter/material.dart';
import 'package:nhameii/Components/gradient_background.dart';
import 'package:nhameii/components/account_setting/account_button.dart';
import 'package:nhameii/components/account_setting/account_header.dart';
import 'package:nhameii/components/account_setting/account_menu_container.dart';

class AccountNotLogIn extends StatefulWidget {
  const AccountNotLogIn({super.key});

  @override
  State<AccountNotLogIn> createState() => _AccountNotLogInState();
}

class _AccountNotLogInState extends State<AccountNotLogIn> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Column(
            children: [
              AccountHeader(name: 'User'),
              const SizedBox(height: 24),
              AccountMenuContainer(
                children: [
                  _buildMenuItem(
                    context,
                    Icons.phone,
                    'About Us',
                    '/about-us',
                  ),
                  _buildMenuItem(
                    context,
                    Icons.phone,
                    'Contact Us',
                    '/contact-us',
                  ),
          
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AccountButton(text: 'Sign up / Log in', onPressed: () {
                      Navigator.pushNamed(context, '/log-in');
                    }),
                  ),
                ],
              ),
            ],
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
