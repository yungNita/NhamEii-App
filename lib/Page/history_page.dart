import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';
import 'package:nhameii/components/gradient_background.dart';
import '../components/navigation_bar/nav_wrapper.dart';
import '../components/cards/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 3,
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                     const BackButtonWidget(),
                      const SizedBox(width: 10),
                      const Text(
                        'History Log',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF44005E),
                        ),
                      ),
                    ],
                  ),
                ),

                // History List
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 8),
                    children: const [
                      HistoryCard(
                        imagePath: 'assets/images/salmon_salad.png',
                        title: 'Salmon salad',
                        subtitle: 'Japanese cuisine',
                        date: '23 Mar 2025',
                      ),
                      HistoryCard(
                        imagePath: 'assets/images/salmon_salad.png',
                        title: 'Salmon rice',
                        subtitle: 'Japanese cuisine',
                        date: '23 Mar 2025',
                      ),
                      HistoryCard(
                        imagePath: 'assets/images/salmon_salad.png',
                        title: 'Salmon rice',
                        subtitle: 'Japanese cuisine',
                        date: '23 Mar 2025',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
