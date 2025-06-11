import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';

import '../components/background.dart';
import '../components/button.dart';

class FoodDetail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const FoodDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
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
                                price,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.9',
                                    style: TextStyle(
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
                      const Text(
                        'This delicious Cambodian dish is perfect for anyone looking to enjoy a rich and traditional flavor. Made with fresh ingredients and cooked with love.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GradientButton(onPressed: () {}, text: 'Add to Cart'),
                        ],
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
