import 'package:flutter/material.dart';
import 'package:nhameii/components/cards/notification_card.dart';

import '../../components/backbutton.dart';
import '../../components/gradient_background.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 15 ),
                child: Row(
                  children: [
                    const BackButtonWidget(),
                    const SizedBox(width: 8),
                    Text(
                      'Notification',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
