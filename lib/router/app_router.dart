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
