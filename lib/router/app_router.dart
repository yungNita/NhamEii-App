import 'package:flutter/material.dart';
import 'package:nhameii/Page/account_page.dart';
import 'package:nhameii/Page/game_page.dart' ;
import 'package:nhameii/Page/history_page.dart';
import 'package:nhameii/Page/home_page.dart';
import 'package:nhameii/Page/q&a_page.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _fadeRoute(const HomePage());
      case '/game':
        return _fadeRoute(const GamePage());
      case '/qa':
        return _fadeRoute(const QAPage());
      case '/history':
        return _fadeRoute(const HistoryPage());
      case '/account':
        return _fadeRoute(const AccountPage());
      default:
        return _fadeRoute(const Scaffold(
          body: Center(child: Text('404: Page Not Found')),
        ));
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:nhameii/Page/account_section/about_us.dart';
import 'package:nhameii/Page/account_section/account_not_log_in.dart';
import 'package:nhameii/Page/account_section/account_page.dart';
import 'package:nhameii/Page/account_section/contactus.dart';
import 'package:nhameii/Page/account_section/edit-profile.dart';
import 'package:nhameii/Page/account_section/faq.dart';
import 'package:nhameii/Page/account_section/history_page.dart';
import 'package:nhameii/Page/account_section/log-in.dart';
import 'package:nhameii/Page/account_section/notification_page.dart';
import 'package:nhameii/Page/account_section/sign-up.dart';
import 'package:nhameii/Page/account_section/termsnpolicies.dart';
import 'package:nhameii/Page/account_section/wishlist_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyAccountPage());

      case '/edit_profile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case '/history':
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => const WishlistPage());

      case '/notification':
        return MaterialPageRoute(builder: (_) => const NotificationPage());

      case '/about-us':
        return MaterialPageRoute(builder: (_) => const AboutUsPage());

      case 'faq':
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
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page Not Found')),
          ),
        );
    }
  }
}


