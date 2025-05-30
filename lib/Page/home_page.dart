import 'package:flutter/material.dart';
import '../Widget/food_card.dart';
import '../Widget/gradient_background.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, 
        body: Center(
          child: FoodCard(
            imageUrl: 'assets/food_card/fish_tomato_mix.png',
            title: 'Fish Tomato \nMix',
            price: '\$3.00',
          ),
        ),
      ),
    );
  }
}
