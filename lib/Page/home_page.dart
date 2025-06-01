import 'package:flutter/material.dart';
import 'package:nhameii/Components/category_card.dart';
import 'package:nhameii/Components/promo_card.dart';
import '../Components/food_card.dart';
import '../Components/gradient_background.dart';
import '../Components/nav_bar.dart'; 

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
        title: 'Khmer Food',
        imagePath: 'assets/khmerFood.jpg',
      ),
      CategoryCard(
        title: 'Khmer Food',
        imagePath: 'assets/khmerFood.jpg',
      ),
      CategoryCard(
        title: 'Khmer Food',
        imagePath: 'assets/khmerFood.jpg',
      ),
      CategoryCard(
        title: 'Khmer Food',
        imagePath: 'assets/khmerFood.jpg',
      ),
    ];

    final List<Widget> promoCards = [
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      PromoCard(imagePath: 'assets/promo1.jpg'),
      
    ];

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 0, bottom: 80), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Popular Card',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44005E),
                  ),
                  textAlign: TextAlign.left,
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
                      children: categoryCard.map((ccard) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: ccard,
                        );
                      }).toList(),
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
                      children: promoCards.map((cardd) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: cardd,
                        );
                      }).toList(),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavBar(
          currentIndex: 0, 
          onTap: (index) {
            print("Tapped index: $index");
          },
        ),
      ),
    );
  }
}
