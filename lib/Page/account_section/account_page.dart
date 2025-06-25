import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nhameii/Page/account_section/edit-profile.dart';
import 'package:nhameii/components/account_setting/account_button.dart';
import 'package:nhameii/components/account_setting/account_header.dart';
import 'package:nhameii/components/account_setting/account_menu_container.dart';
import 'package:nhameii/components/gradient_background.dart';
import 'package:nhameii/services/local_image_service.dart';
import 'package:nhameii/components/navigation_bar/nav_wrapper.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  File? _profileImage;
  bool _isLoadingImage = false;
  bool _isLoadingData = true;
  String? _displayName;
  String? _email;
  String? _currentUserId;
  StreamSubscription<DocumentSnapshot>? _userSubscription;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserId = user.uid;
        _displayName = user.displayName;
        _email = user.email;
      });
      await _setupUserListener(user.uid);
      await _loadLocalProfileImage();
    }
    setState(() => _isLoadingData = false);
  }

  Future<void> _setupUserListener(String userId) async {
    _userSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists && mounted) {
            setState(() {
              _displayName = snapshot.get('displayName') ?? _displayName;
              _email = snapshot.get('email') ?? _email;
            });
          }
        });
  }

  Future<void> _loadLocalProfileImage() async {
    if (_currentUserId == null) return;

    setState(() => _isLoadingImage = true);
    try {
      final image = await LocalImageService.getProfileImage(_currentUserId!);
      if (mounted) {
        setState(() => _profileImage = image);
      }
    } catch (e) {
      print('Error loading profile image: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoadingImage = false);
      }
    }
  }

  Future<void> _pickAndSaveImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 90,
      );
      
      if (pickedFile != null && _currentUserId != null) {
        setState(() => _isLoadingImage = true);
        
        // Compress and save image
        final compressedImage = await _compressImage(File(pickedFile.path));
        final savedImage = await LocalImageService.saveProfileImage(
          _currentUserId!,
          compressedImage,
        );
        
        if (mounted) {
          setState(() {
            _profileImage = savedImage;
            _isLoadingImage = false;
          });
        }
      }
    } catch (e) {
      print('Error updating profile image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile image: ${e.toString()}')),
        );
        setState(() => _isLoadingImage = false);
      }
    }
  }

  Future<File> _compressImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      final compressedImage = img.encodeJpg(decodedImage!, quality: 85);
      
      // Create temp file for compressed image
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final compressedFile = File(tempPath)..writeAsBytesSync(compressedImage);
      
      return compressedFile;
    } catch (e) {
      print('Error compressing image: $e');
      return imageFile; // Return original if compression fails
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
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
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await _logout();
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

  Future<void> _logout() async {
    try {
      // Clear local profile image reference
      if (mounted) {
        setState(() {
          _profileImage = null;
          _isLoadingData = true;
        });
      }
      
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      
      // Handle Google Sign-In if used
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }

      // Navigate to login screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/account-not-log-in');
      }
    } catch (e) {
      print('Logout error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to log out. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/account-not-log-in');
      });
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_isLoadingData) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                    AccountHeader(
                      name: _displayName ?? 'User',
                      email: _email ?? 'user@example.com',
                      profileImage: _profileImage,
                      isLoading: _isLoadingImage,
                      onEditPhoto: _isLoadingImage ? null : _pickAndSaveImage,
                    ),
                    const SizedBox(height: 18),
                    AccountMenuContainer(
                      children: [
                        _buildMenuItem(
                          context,
                          Icons.person_outline,
                          'Edit Profile',
                          '/edit_profile',
                          user: user,
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
                          child: AccountButton(
                            text: 'Log out',
                            onPressed: () => _showLogoutDialog(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // In your _buildMenuItem method where you navigate to EditProfileScreen
Widget _buildMenuItem(
  BuildContext context,
  IconData icon,
  String title,
  String routeName, {
  User? user,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.black, size: 26),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.black),
    ),
    onTap: () async {
      if (routeName == '/edit_profile' && user != null) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(
              userId: user.uid,
              currentName: _displayName ?? user.displayName ?? 'User',
              currentEmail: user.email ?? '', // Use auth email, not Firestore
              profileImage: _profileImage,
              onImageChanged: (File? newImage) {
                setState(() => _profileImage = newImage);
              },
              onProfileUpdated: () {
                // Reload user data including auth state
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  setState(() {
                    _displayName = currentUser.displayName;
                    _email = currentUser.email;
                  });
                  _setupUserListener(currentUser.uid);
                }
              },
            ),
          ),
        );

        if (result != null) {
          setState(() {
            _displayName = result['name'] ?? _displayName;
            // Don't update email here - it comes from auth state
            _profileImage = result['image'] ?? _profileImage;
          });
        }
      } else {
        Navigator.pushNamed(context, routeName);
      }
    },
  );
}
}