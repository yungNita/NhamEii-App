import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  final String name;
  final String? email;

  const AccountHeader({
    super.key,
    required this.name,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF3E0061),
                size: 24,
              ),
              onPressed: () {
                // Push home and replace this screen
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            const Text(
              'My Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E0061),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E0061),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email ?? 'Email Address',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
