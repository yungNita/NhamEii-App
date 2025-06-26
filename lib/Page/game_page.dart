import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:nhameii/data/recommeded_foods.dart';
import 'package:nhameii/models/food_items.dart';
import '../components/navigation_bar/nav_wrapper.dart';
import '../components/gradient_background.dart';

class GamePage extends StatefulWidget {
  // const GamePage({super.key});
  final List<String>? foodsFromQuiz;

  const GamePage({super.key, this.foodsFromQuiz});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final StreamController<int> controller = StreamController<int>.broadcast();
  final List<String> recommendedFoods = [
    'Fish Amok',
    'Bok Kapi',
    'Grilled Fish',
    'Somlor Korko',
    'Koung',
    'Loklak',
  ];
  List<String> userFoods = [];
  bool useUserFoods = false;
  bool hasSpunOnce = false;

  String? lastResult;
  bool isResultFromRecommendation = false;

  int selected = 0;
  bool isSpinning = false;

  List<String> get items {
    if (widget.foodsFromQuiz != null && widget.foodsFromQuiz!.isNotEmpty) {
      return widget.foodsFromQuiz!;
    } else if (useUserFoods && userFoods.isNotEmpty) {
      return userFoods;
    } else {
      return recommendedFoods;
    }
  }

  void spinWheel() {
    if (items.isEmpty || isSpinning) return;

    final index1 = Random().nextInt(items.length);
    setState(() {
      isSpinning = true;
      hasSpunOnce = true;
      selected = index1;
    });

    controller.add(index1);
  }

  void onWheelAnimationEnd() {
    if (!hasSpunOnce) return;

    setState(() {
      isSpinning = false;
      lastResult = items[selected];
      isResultFromRecommendation =
          !useUserFoods || !userFoods.contains(lastResult);
    });

    showResultDialog();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   controller = StreamController<int>();
  //   isSpinning = false;
  //   hasSpunOnce = false; // Reset on fresh page
  // }

  void promptUserForFood() {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a food'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(hintText: 'Food name'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final String food = textController.text.trim();
                if (food.isNotEmpty) {
                  setState(() {
                    userFoods = List.from(userFoods)..add(food);
                    useUserFoods = true;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  FoodItem? getFoodItemByName(String name) {
    if (name.isEmpty) return null;
    try {
      return recommendedFoodItems.firstWhere(
        (item) => item.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  void showResultDialog() {
    final foodItem = getFoodItemByName(lastResult ?? '');

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('🎉 Your result'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You got ${foodItem?.name ?? lastResult}!',
                  style: const TextStyle(fontSize: 20),
                ),
                if (foodItem != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(foodItem.imageUrl, height: 120),
                  ),
                if (foodItem != null)
                  Text(
                    foodItem.price,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            actions: [
              if (isResultFromRecommendation && foodItem != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(
                      context,
                      '/food/${foodItem.name.toLowerCase()}',
                    );
                  },
                  child: const Text('View Food'),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NavWrapper(
        currentIndex: 1,
        child: GradientBackground(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Game title
                Row(
                  children: const [
                    SizedBox(width: 25),
                    SizedBox(height: 80),
                    Text(
                      'Game ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF44005E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              useUserFoods = true;
                            });
                            promptUserForFood();
                          },
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Input your own foods'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                useUserFoods
                                    ? const Color(0xFFD8007A)
                                    : Colors.white,
                            foregroundColor:
                                useUserFoods ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            side: BorderSide(
                              color:
                                  useUserFoods
                                      ? const Color(0xFFD8007A)
                                      : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              useUserFoods = false;
                            });
                          },
                          icon: const Icon(Icons.auto_awesome, size: 18),
                          label: const Text('Our Recommendation'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                !useUserFoods
                                    ? const Color(0xFFD8007A)
                                    : Colors.white,
                            foregroundColor:
                                !useUserFoods ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            side: BorderSide(
                              color:
                                  !useUserFoods
                                      ? const Color(0xFFD8007A)
                                      : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                // Wheel container
                SizedBox(
                  width: 300,
                  height: 300,
                  child:
                      items.length > 1
                          ? FortuneWheel(
                            selected: controller.stream,
                            items: [
                              for (var food in items)
                                FortuneItem(child: Text(food)),
                            ],
                            indicators: const <FortuneIndicator>[
                              FortuneIndicator(
                                alignment: Alignment.topCenter,
                                child: TriangleIndicator(color: Colors.black),
                              ),
                            ],
                            onAnimationEnd: onWheelAnimationEnd,
                          )
                          : const Center(
                            child: Text(
                              'Please add at least 2 foods to spin the wheel!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                ),
                const SizedBox(height: 30),
                // Spin button
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed:
                        items.length > 1 && !isSpinning ? spinWheel : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [Color(0xFFFD4EB1), Color(0xFFD8007A)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          isSpinning ? "Spinning..." : "Spin",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
