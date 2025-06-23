import 'package:nhameii/Page/food_detail.dart';
import 'package:nhameii/Page/game_page.dart' ;
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
import 'package:nhameii/Page/question_answer.dart';
import 'package:nhameii/Page/splashscreen.dart';
import 'package:nhameii/data/recommeded_foods.dart';


class AppRouter {
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
          
        ),
      );
        }

    //  STEP 3: Continue with normal routes
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
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => const WishlistPage());
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
      default:
        return _errorRoute('Page Not Found 🕳️');
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
