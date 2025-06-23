// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nhameii/Page/account_section/food_recommend.dart';
import 'package:nhameii/components/gradient_background.dart';
import 'package:nhameii/components/navigation_bar/nav_wrapper.dart';
import 'package:nhameii/components/q&a/title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QAData {
  final String question;
  final List<String> answers;
  final String imagePath;
  final bool isMultiple;

  QAData({
    required this.question,
    required this.answers,
    required this.imagePath,
    this.isMultiple = false,
  });
}

class QnAFlowPage extends StatefulWidget {
  const QnAFlowPage({super.key});

  @override
  State<QnAFlowPage> createState() => _QnAFlowPageState();
}

class _QnAFlowPageState extends State<QnAFlowPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  Map<int, dynamic> selectedAnswers = {};

  final List<QAData> questions = [
    QAData(
      question: "What meal are you looking for right now?",
      answers: ["Breakfast", "Lunch", "Dinner", "Snack", "Dessert", "Beverage"],
      imagePath: 'assets/images/peng.png',
    ),
    QAData(
      question: "Do you have any dietary preferences or restrictions?",
      answers: [
        "Vegetarian",
        "Vegan",
        "Halal",
        "No beef",
        "No pork",
        "Egg-free",
        "No seafood",
        "I eat everything",
      ],
      imagePath: 'assets/images/peng.png',
      isMultiple: true,
    ),
    QAData(
      question: "How much time do you have to prepare or wait for food?",
      answers: [
        "5–10 minutes",
        "10–30 minutes",
        "Over 30 minutes",
        "Doesn’t matter",
      ],
      imagePath: 'assets/images/peng.png',
    ),
    QAData(
      question: "What flavors do you enjoy the most?",
      answers: [
        "Sweet",
        "Salty",
        "Spicy",
        "Sour",
        "Savory/Umami",
        "Bitter",
        "Mild",
      ],
      imagePath: 'assets/images/peng.png',
      isMultiple: true,
    ),
    QAData(
      question: "What kind of cuisine are you in the mood for?",
      answers: [
        "Khmer",
        "Korean",
        "Chinese",
        "Japanese",
        "Thai",
        "Western",
        "Middle Eastern",
        "Indian",
        "Surprise me",
      ],
      imagePath: 'assets/images/peng.png',
    ),
    QAData(
      question: "What type of food are you craving?",
      answers: [
        "Rice dishes",
        "Noodle dishes",
        "Soup/Stew",
        "Grilled/BBQ",
        "Salad or raw food",
        "Bread or bakery",
        "Fried food",
        "Healthy options",
        "Comfort food",
        "Dessert / Sweet treat",
      ],
      imagePath: 'assets/images/peng.png',
      isMultiple: true,
    ),
  ];

  void toggleAnswer(int index, String answer) {
    final isMulti = questions[index].isMultiple;
    final questionText = questions[index].question;

    setState(() {
      if (isMulti) {
        final current = (selectedAnswers[index] as List<String>? ?? []);

        // Special logic for "Do you have any dietary preferences or restrictions?"
        if (questionText ==
            "Do you have any dietary preferences or restrictions?") {
          const everythingOption = "I eat everything";

          if (answer == everythingOption) {
            // If selecting "I eat everything", clear others and select only it
            selectedAnswers[index] = [everythingOption];
            return;
          }

          // If "I eat everything" is already selected and another is tapped, remove it
          if (current.contains(everythingOption)) {
            current.remove(everythingOption);
          }

          // Enforce max 7
          if (current.contains(answer)) {
            current.remove(answer);
          } else if (current.length < 7) {
            current.add(answer);
          }

          selectedAnswers[index] = current;
        }
        // Other multiple choice logic (with max 4)
        else {
          if (current.contains(answer)) {
            current.remove(answer);
          } else if (current.length < 4) {
            current.add(answer);
          }
          selectedAnswers[index] = current;
        }
      } else {
        selectedAnswers[index] = answer;
      }
    });
  }

  bool hasSelection(int index) {
    final answer = selectedAnswers[index];
    if (questions[index].isMultiple) {
      return (answer != null && (answer as List).isNotEmpty);
    } else {
      return answer != null && answer is String;
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
            PageTitle(title: 'Q&A for recommendations'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  final selected = selectedAnswers[index];
                  final isLast = index == questions.length - 1;
                  final canProceed = hasSelection(index);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question Progress
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Question ${index + 1}/${questions.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A015A),
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),

                          // Question Box
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9E9FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    q.question,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3A015A),
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                Image.asset(q.imagePath, width: 80, height: 80),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Answer Type Text
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              q.isMultiple
                                  ? (q.question.contains(
                                            "What flavors do you enjoy the most",
                                          ) ||
                                          q.question.contains(
                                            "What type of food are you craving",
                                          ))
                                      ? "Multiple answers allowed (Choose up to 4)"
                                      : "Multiple answers allowed"
                                  : "Single answer",
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF3A015A),
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),

                          // Answer Choices
                          GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children:
                                q.answers.map((a) {
                                  final isSelected =
                                      q.isMultiple
                                          ? ((selected as List<String>? ?? [])
                                              .contains(a))
                                          : selected == a;
                                  return GestureDetector(
                                    onTap: () => toggleAnswer(index, a),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient:
                                            isSelected
                                                ? const LinearGradient(
                                                  colors: [
                                                    Color(0xFFFD4EB1),
                                                    Color(0xFFD8007A),
                                                  ],
                                                )
                                                : null,
                                        border: Border.all(
                                          color: const Color(0xFFFD4EB1),
                                          width: 1.5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: Center(
                                        child: Text(
                                          a,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : const Color(0xFF3A015A),
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),

                          const SizedBox(height: 40),

                          // Navigation Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (index > 0)
                                TextButton(
                                  onPressed: () {
                                    _controller.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                    setState(() => currentIndex--);
                                  },
                                  child: const Text(
                                    "Back",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3A015A),
                                    ),
                                  ),
                                ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient:
                                        canProceed
                                            ? const LinearGradient(
                                              colors: [
                                                Color(0xFFFD4EB1),
                                                Color(0xFFD8007A),
                                              ],
                                            )
                                            : null,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextButton(
                                    onPressed:
                                        canProceed
                                            ? () async {
                                              if (isLast) {
                                                final formatedAnswers = questions.asMap().map((i, q){
                                                  final value = selectedAnswers[i];
                                                  return MapEntry(q.question, value is List ? value : [value]);
                                                });


                                                // final userAnswers = selectedAnswers.map((key, value){
                                                //   return MapEntry('$Key', value is List ? value : [value]);
                                                // });

                                                await FirebaseFirestore.instance.collection('userAnswers').add({
                                                  'timestamp' : FieldValue.serverTimestamp(),
                                                  'answers': formatedAnswers,
                                                  // 'userId': 
                                                });
                                                // Navigate to FoodRecommend page
                                                
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => FoodRecommend(selectedAnswers: selectedAnswers),));
                                              } else {
                                                _controller.nextPage(
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                                setState(() => currentIndex++);
                                              }
                                            }
                                            : null,
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                        right: 25,
                                        left: 25,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      isLast ? "Finish" : "Next",
                                      style: TextStyle(
                                        color:
                                            canProceed
                                                ? Colors.white
                                                : const Color(0xFF3A015A),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
