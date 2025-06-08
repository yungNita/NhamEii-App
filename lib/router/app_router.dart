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
