import 'package:flutter/material.dart';
import 'package:nhameii/Widget/category_card.dart';
import '../Widget/food_card.dart';
import '../Widget/gradient_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> foodCards = [
      FoodCard(
        imageUrl: 'assets/fish_tomato_mix.png',
        title: 'Fish Tomato \nSalad',
        price: '\$12.99',
      ),
      FoodCard(
        imageUrl: 'assets/fish_tomato_mix.png',
        title: 'Chicken \nCurry',
        price: '\$9.99',
      ),
      FoodCard(
        imageUrl: 'assets/fish_tomato_mix.png',
        title: 'Beef Noodle',
        price: '\$10.50',
      ),
      FoodCard(
        imageUrl: 'assets/fish_tomato_mix.png',
        title: 'Fish Tomato \nSalad',
        price: '\$12.99',
      ),
      FoodCard(
        imageUrl: 'assets/fish_tomato_mix.png',
        title: 'Chicken \nCurry',
        price: '\$9.99',
      ),
      FoodCard(
        imageUrl: 'assets/fish_tomato_mix.png',
        title: 'Beef Noodle',
        price: '\$10.50',
      ),
    ];
    final List<Widget> categoryCard = [
      CategoryCard(
        title: 'khmer Food', 
        imagePath: 'assets/khmerFood.jpg',
      ),
      CategoryCard(
        title: 'khmer Food', 
        imagePath: 'assets/khmerFood.jpg',
      ),
      CategoryCard(
        title: 'khmer Food', 
        imagePath: 'assets/khmerFood.jpg',
      ),
      CategoryCard(
        title: 'khmer Food', 
        imagePath: 'assets/khmerFood.jpg',
      ),
    ];

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Container(
                color: Colors.transparent,
                child: const Text(
                  'Popular Card',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44005E),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
              height: 245,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: foodCards.map((card) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: card,
                    );
                  }).toList(),
                ),
              ),
            ),

              // cagtegory
              Container(
                color: Colors.transparent,
                child: const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44005E),
                  )
                )
              ),
              SizedBox(
              height: 200, 
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryCard.map((ccard) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: ccard,
                    );
                  }).toList(),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
