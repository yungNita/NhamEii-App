import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nhameii/services/firebase_user_service.dart';
import 'package:nhameii/services/local_image_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../../components/backbutton.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;
  final String currentName;
  final String currentEmail;
  final File? profileImage;
  final Function(File?)? onImageChanged;
  final VoidCallback? onProfileUpdated;

  const EditProfileScreen({
    super.key,
    required this.userId,
    required this.currentName,
    required this.currentEmail,
    this.profileImage,
    this.onImageChanged,
    this.onProfileUpdated,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  File? _selectedImage;
  bool _isSaving = false;
  bool _showPasswordFields = false;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _emailChanged = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    
    // Listen for email changes
    emailController.addListener(() {
      setState(() {
        _emailChanged = emailController.text != widget.currentEmail;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _saveProfile() async {
  if (_isSaving || !_formKey.currentState!.validate()) return;

  setState(() => _isSaving = true);
  try {
    // Show saving indicator
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving changes...')),
      );
    }

    // 1. Handle Image Update
    File? savedImage;
    if (_selectedImage != null) {
      savedImage = await LocalImageService.saveProfileImage(
        widget.userId,
        _selectedImage!,
      );
    }

    // 2. Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not logged in');

    // Debug current user state
    debugPrint('User provider data: ${user.providerData.map((p) => p.providerId)}');
    // debugPrint('Email verified: ${user.emailVerified}');

    // 3. Verify current email is verified
    // if (!user.emailVerified) {
    //   await user.sendEmailVerification();
    //   throw Exception('Please verify your current email before making changes. Verification email sent.');
    // }

    // 4. Handle Email Change
    // if (_emailChanged) {
    //   if (passwordController.text.isEmpty) {
    //     throw Exception('Current password is required to change email');
    //   }

    //   // Reauthenticate user
    //   try {
    //     final credential = EmailAuthProvider.credential(
    //       email: user.email!,
    //       password: passwordController.text,
    //     );
    //     await user.reauthenticateWithCredential(credential);
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'wrong-password') {
    //       throw Exception('Incorrect current password');
    //     }
    //     throw Exception('Reauthentication failed: ${e.message}');
    //   }

    //   // Update email
    //   try {
    //     await user.updateEmail(emailController.text);
    //     await user.sendEmailVerification();
        
    //     if (mounted) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(
    //           content: Text('Verification email sent to your new address. Please verify it.'),
    //           duration: Duration(seconds: 5),
    //         ),
    //       );
    //     }
    //   } on FirebaseAuthException catch (e) {
    //     switch (e.code) {
    //       case 'requires-recent-login':
    //         throw Exception('This operation requires recent authentication. Please log out and back in.');
    //       case 'email-already-in-use':
    //         throw Exception('This email is already registered with another account');
    //       case 'invalid-email':
    //         throw Exception('Please enter a valid email address');
    //       case 'operation-not-allowed':
    //         throw Exception('Email/password accounts are not enabled. Check Firebase Auth settings.');
    //       default:
    //         throw Exception('Email update failed: ${e.message}');
    //     }
    //   }
    // }

    // 5. Handle Password Change
    if (_showPasswordFields && newPasswordController.text.isNotEmpty) {
      if (passwordController.text.isEmpty) {
        throw Exception('Current password is required to change password');
      }

      try {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: passwordController.text,
        );
        await user.reauthenticateWithCredential(credential);
        
        // Update password
        await user.updatePassword(newPasswordController.text);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw Exception('Password must be at least 6 characters');
        }
        throw Exception('Password update failed: ${e.message}');
      }
    }

    // 6. Update Firestore Profile
    try {
      await FirebaseUserService.updateUserProfile(
        userId: widget.userId,
        name: nameController.text,
        email: emailController.text,
      );
    } catch (e) {
      throw Exception('Failed to update profile data: ${e.toString()}');
    }

    // 7. Notify parent and return
    widget.onProfileUpdated?.call();
    if (savedImage != null && widget.onImageChanged != null) {
      widget.onImageChanged!(savedImage);
    }

    if (mounted) {
      Navigator.pop(context, {
        'name': nameController.text,
        'email': emailController.text,
        'image': savedImage,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  } catch (e) {
    debugPrint('Profile update error: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }
}
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final currentImage = _selectedImage ?? widget.profileImage;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE3DFFF), Color(0xFFFDE4F8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: currentImage != null
                                ? FileImage(currentImage!)
                                : null,
                            child: currentImage == null
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
                                color: Color.fromARGB(255, 56, 0, 66),
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
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Email",
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            
                            // Always show password field when email is changed
                            // if (_emailChanged) ...[
                              const SizedBox(height: 9),
                              Text(
                                "Email cannot be changed",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromARGB(255, 255, 36, 36),
                                ),
                              ),
                              
                            // ],
                            
                           
                            // if (!_emailChanged) ...[
                              const SizedBox(height: 20),
                                Text(
                                  "Current Password",
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your current password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (_showPasswordFields && 
                                        (value == null || value.isEmpty)) {
                                      return 'Current password required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "New Password",
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextFormField(
                                  controller: newPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter new password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (_showPasswordFields &&
                                        value != null &&
                                        value.isNotEmpty &&
                                        value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                              // ],
                            // ],
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: ElevatedButton(
                                    onPressed: _isSaving ? null : _saveProfile,
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
                                      child: _isSaving
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 1,
                                              ),
                                            )
                                          : const Text(
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
          ),
        ],
      ),
    );
  }
}