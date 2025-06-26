import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';
import '../components/background.dart';
import '../components/button.dart';

class FoodDetail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String detail;
  final String rating;

  const FoodDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.detail,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 400,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/background3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BackButtonWidget(),
                            const SizedBox(height: 20),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  imageUrl,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 120),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$'+price,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          rating,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              detail,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 80), // Spacer before bottom bar
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$'+price,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GradientButton(onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    }, text: 'Eat Now!'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
