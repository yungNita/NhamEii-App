import 'package:flutter/material.dart';
import 'package:nhameii/Components/backbutton.dart';
import 'package:nhameii/Components/gradient_background.dart';
import 'package:nhameii/Components/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            BackButtonWidget(),
                    const SizedBox(width: 8),
                    Text(
                      'Edit Profile',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            NotificationCard(
              icon: Icons.notifications, 
              message:
                  '🍽️ Your next favorite meal is ready! Check out your personalized food recommendations now!',
              timestamp: 'now',
            ),
            NotificationCard(
              icon: Icons.notifications, 
              message:
                  '🍽️ Your next favorite meal is ready! Check out your personalized food recommendations now!',
              timestamp: 'now',
            ),
            NotificationCard(
              icon: Icons.notifications, 
              message:
                  '🍽️ Your next favorite meal is ready! Check out your personalized food recommendations now!',
              timestamp: 'now',
            ),
            NotificationCard(
              icon: Icons.notifications, 
              message:
                  '🍽️ Your next favorite meal is ready! Check out your personalized food recommendations now!',
              timestamp: 'now',
            ),
          ],
        ),
      ),
    );
  }
}
