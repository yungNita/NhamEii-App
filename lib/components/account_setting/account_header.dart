import 'package:flutter/material.dart';
import 'dart:io';

class AccountHeader extends StatelessWidget {
  final String name;
  final String? email;
  final File? profileImage;
  final bool isLoading;
  final VoidCallback? onEditPhoto;

  const AccountHeader({
    super.key,
    required this.name,
    this.email,
    this.profileImage,
    this.onEditPhoto,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
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
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                if (isLoading)
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person, 
                            size: 40, 
                            color: Colors.white
                          )
                        : null,
                  ),
                if (onEditPhoto != null && !isLoading)
                  GestureDetector(
                    onTap: onEditPhoto,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8007A),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
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