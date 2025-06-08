// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:nhameii/Components/backbutton.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController(text: "Jameson");
  final emailController = TextEditingController(
    text: "jamesonstephenson@gmail.com",
  );

  File? _profileImage;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3DFFF), Color(0xFFFDE4F8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    BackButtonWidget(),
                    const SizedBox(width: 8),
                    Text(
                      'Edit Profile',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Avatar with uploaded image
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage:
                          _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                      child:
                          _profileImage == null
                              ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
                              : null,
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Name",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(controller: nameController),
                      const SizedBox(height: 16),
                      Text(
                        "Email",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(controller: emailController),
                      const SizedBox(height: 16),
                      Text(
                        "Password",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter old password",
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter new password",
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Confirm new password",
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(

                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 30.0),
                          //   child: TextButton(
                          //     onPressed: () => Navigator.pop(context),
                          //     child: Text(
                          //       "Cancel",
                          //       style: textTheme.titleMedium?.copyWith(
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                elevation: 3,
                                shadowColor: Colors.transparent,
                              ),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFD4EB1),
                                      Color(0xFFD8007A),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 24,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Game",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: "Q&A",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
