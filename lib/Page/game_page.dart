import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../components/nav_wrapper.dart';
import '../components/gradient_background.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final StreamController<int> controller = StreamController<int>();
  final List<String> items = [
    'Pasta',
    'Hot dog',
    'Salad',
    'Bacon',
    'Sushi',
    'Burrito',
    'Pizza',
    'Burger',
    'Thai',
    'Taco',
    'Stew',
    'Soup',
    'Sandwich',
    'Steak',
    'Chinese',
    'BBQ',
  ];

  void spinWheel() {
    final index = Random().nextInt(items.length);
    controller.add(index);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 1,
      child: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
             

                 
              // Game title
              Row(
                children: [
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF44005E),
                    ),
                  ),

                  const SizedBox(width: 10),
                  const Text(
                    'Game',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF44005E)),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ✍️ Buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // handle custom input
                        },
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Input your own foods'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: spinWheel,
                        child: const Text('Our Recommendation'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Fortune wheel
              Expanded(
                child: FortuneWheel(
                  selected: controller.stream,
                  items: [
                    for (var food in items) FortuneItem(child: Text(food)),
                  ],
                  indicators: const <FortuneIndicator>[
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: TriangleIndicator(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // pin Button
              ElevatedButton(
                onPressed: spinWheel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7F3DFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                child: const Text("Spin", style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
