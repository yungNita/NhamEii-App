import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nhameii/components/cards/food_card.dart';
import 'package:nhameii/components/gradient_background.dart';
import 'package:nhameii/components/navigation_bar/nav_wrapper.dart';
import 'package:nhameii/components/q&a/title.dart';
import 'package:nhameii/Page/game_page.dart';
import 'package:nhameii/data/food_image.dart';

class FoodRecommend extends StatefulWidget {
  final Map<int, dynamic> selectedAnswers;

  const FoodRecommend({super.key, required this.selectedAnswers});

  @override
  State<FoodRecommend> createState() => _FoodRecommendState();
}

class _FoodRecommendState extends State<FoodRecommend> {
  List<Map<String, dynamic>> recommendedFoods = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecommendedFoods();
  }

  Future<void> _fetchRecommendedFoods() async {
    final answers = widget.selectedAnswers;

    final selectedTags = <String>{
      ...(answers[0] is List ? answers[0] : [answers[0]]), // meal
      ...(answers[1] is List ? answers[1] : [answers[1]]), // dietary
      ...(answers[2] is List ? answers[2] : [answers[2]]), // prepTime
      ...(answers[3] is List ? answers[3] : [answers[3]]), // flavors
      ...(answers[4] is List ? answers[4] : [answers[4]]), // cuisine
      ...(answers[5] is List ? answers[5] : [answers[5]]), // type
    };

    try {
      final snapshot = await FirebaseFirestore.instance.collection('foods').get();

      final foods = snapshot.docs.map((doc) {
        final data = doc.data();

        int score = 0;

        if (answers[0] != null) {
          final meal = List<String>.from(data['meal'] ?? []);
          score += meal.where((m) => selectedTags.contains(m)).length;
        }

        if (answers[1] != null) {
          final dietary = List<String>.from(data['dietary'] ?? []);
          score += dietary.where((d) => selectedTags.contains(d)).length;
        }

        if (answers[2] != null && selectedTags.contains(data['prepTime'])) {
          score += 1;
        }

        if (answers[3] != null) {
          final flavors = List<String>.from(data['flavors'] ?? []);
          score += flavors.where((f) => selectedTags.contains(f)).length;
        }

        if (answers[4] != null && selectedTags.contains(data['cuisine'])) {
          score += 1;
        }

        if (answers[5] != null) {
          final type = List<String>.from(data['type'] ?? []);
          score += type.where((t) => selectedTags.contains(t)).length;
        }

        return {
          'name': data['name'],
          'price': data['price'].toString(),
          'imageKey': data['foodId'] ?? '',
          
          'score': score,
        };
      }).toList();

      foods.sort((a, b) => b['score'].compareTo(a['score']));

      setState(() {
        recommendedFoods = foods.take(4).toList();
        loading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 2,
      child: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: PageTitle(title: 'Q&A for recommendations'),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9E9FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Here is our recommended food based on your answers!!',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3A015A),
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/peng.png',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              if (loading)
                const Center(child: CircularProgressIndicator())
              else
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          height: 380,
                          width: 310,
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 90,
                            crossAxisSpacing: 20,
                            physics: const NeverScrollableScrollPhysics(),
                            children: recommendedFoods.map((food) {
                              final imageUrl = foodImages[food['imageKey']] ?? 'assets/images/peng.png';
                              return FoodCard(
                                title: food['name'],
                                price: '\$${food['price']}',
                                imageUrl: imageUrl,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _spinButton(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spinButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFD4EB1), Color(0xFFD8007A)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GamePage()),
          );
        },
        child: const Text(
          'Spin all these food',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
