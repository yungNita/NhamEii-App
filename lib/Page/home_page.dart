
import 'package:flutter/material.dart';
import 'package:nhameii/components/category_card.dart';
import 'package:nhameii/components/nav_wrapper.dart';
import 'package:nhameii/components/promo_card.dart';

import '/components/seemore_button.dart';
import '../components/food_card.dart';
import '../components/gradient_background.dart';
import '../components/header_home_page.dart';
import '../Components/nav_bar.dart';
import 'categorylist.dart';

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

    final List<CategoryCard> categoryCard = [
      CategoryCard(
        title: 'Khmer Food',
        imagePath: 'assets/images/category/khmer.png',
        type: ['Asian'],
      ),
      CategoryCard(
        title: 'Burger',
        imagePath: 'assets/images/category/burger.png',
        type: ['Western'],
      ),
      CategoryCard(
        title: 'Green Salad',
        imagePath: 'assets/images/category/salad.png',
        type: ['Vegetarian'],
      ),
      CategoryCard(
        title: 'Cake',
        imagePath: 'assets/images/category/cake.png',
        type: ['Snack', 'Dessert', 'Vegetarian', 'Halal', 'Trending'],
      ),
      CategoryCard(
        title: 'Pastry',
        imagePath: 'assets/images/category/pastry.png',
        type: ['Snack', 'Dessert', 'Vegetarian', 'Halal', 'Trending'],
      ),
    ];

    final List<Widget> promoCards = [
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
    ];
    return NavWrapper(
    currentIndex: 0, //current index for HomePage
    child: GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 0,
                bottom: 80,
              ), // Padding so content doesn't hide under navbar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Popular Card',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44005E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 245,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            foodCards
                                .map(
                                  (card) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: card,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44005E),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            categoryCard
                                .map(
                                  (ccard) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0,
                                    ),
                                    child: ccard,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Promotions',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44005E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 190,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            promoCards
                                .map(
                                  (cardd) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0,
                                    ),
                                    child: cardd,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // extra space at bottom
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
