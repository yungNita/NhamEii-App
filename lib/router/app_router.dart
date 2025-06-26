import 'package:nhameii/Page/food_detail.dart';
import 'package:nhameii/Page/game_page.dart';
import 'package:nhameii/Page/history_page.dart';
import 'package:nhameii/Page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:nhameii/Page/account_section/about_us.dart';
import 'package:nhameii/Page/account_section/account_not_log_in.dart';
import 'package:nhameii/Page/account_section/account_page.dart';
import 'package:nhameii/Page/account_section/contactus.dart';
import 'package:nhameii/Page/account_section/edit-profile.dart';
import 'package:nhameii/Page/account_section/faq.dart';
import 'package:nhameii/Page/account_section/log-in.dart';
import 'package:nhameii/Page/account_section/notification_page.dart';
import 'package:nhameii/Page/account_section/sign-up.dart';
import 'package:nhameii/Page/account_section/termsnpolicies.dart';
import 'package:nhameii/Page/account_section/wishlist_page.dart';
import 'package:nhameii/Page/search_page.dart';
import 'package:nhameii/Page/search_results_page.dart';
import 'package:nhameii/Page/question_answer.dart';
import 'package:nhameii/Page/splashscreen.dart';
import 'package:nhameii/data/recommeded_foods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppRouter {
  static File? _profileImage; // Local storage for profile image

  static Future<void> _loadProfileImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.jpg';
      final imageFile = File(imagePath);
      
      if (await imageFile.exists()) {
        _profileImage = imageFile;
      }
    } catch (e) {
      debugPrint('Error loading profile image: $e');
    }
  }

  static Future<void> _updateProfileImage(File? newImage) async {
    try {
      if (newImage != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/profile_image.jpg';
        await newImage.copy(imagePath);
        _profileImage = File(imagePath);
      } else {
        _profileImage = null;
      }
    } catch (e) {
      debugPrint('Error updating profile image: $e');
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'food') {
      final foodName = uri.pathSegments[1];
      final foodItem = recommendedFoodItems.firstWhere(
        (item) => item.name.toLowerCase() == foodName.toLowerCase(),
        orElse: () => throw Exception('Food not found'),
      );

      return MaterialPageRoute(
        builder: (_) => FoodDetail(
          imageUrl: foodItem.imageUrl,
          title: foodItem.name,
          price: foodItem.price,
          detail: foodItem.description,
          rating: foodItem.rating,
          
        ),
      );
    }

    switch (settings.name) {
      case '/':
        return _fadeRoute(const SplashScreen());
      case '/home':
        return _fadeRoute(const HomePage());
      case '/game':
        return _fadeRoute(const GamePage());
      case '/qa':
        return _fadeRoute(const QnAFlowPage());
      case '/history':
        return _fadeRoute(const HistoryPage());
      case '/account':
        return _fadeRoute(const MyAccountPage());
      case '/edit_profile':
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return _fadeRoute(const LoginScreen());
        }
        
        // Load profile image if not already loaded
        if (_profileImage == null) {
          _loadProfileImage();
        }

        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(
            userId: user.uid,
            currentName: user.displayName ?? 'User',
            currentEmail: user.email ?? '',
            profileImage: _profileImage,
            onImageChanged: (newImage) async {
              await _updateProfileImage(newImage);
            },
          ),
        );
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => WishlistPage(wishlistItems: const []));
      case '/notification':
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case '/about-us':
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      case '/faq':
        return MaterialPageRoute(builder: (_) => Faqs());
      case '/term-and-polocies':
        return MaterialPageRoute(builder: (_) => const Termsnpolicies());
      case '/contact-us':
        return MaterialPageRoute(builder: (_) => const ContactUs());
      case '/account-not-log-in':
        return MaterialPageRoute(builder: (_) => const AccountNotLogIn());
      case '/log-in':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case '/search-results':
        return MaterialPageRoute(builder: (_) => const SearchResultsPage(query: '***'));

      default:
        return _errorRoute('Page Not Found ');
    }
  }

  // Fade transition helper
  static PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Error fallback route
  static Route _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}