import 'package:flutter/material.dart';
import 'package:nhameii/Page/categorylist.dart';
import 'package:nhameii/components/cards/category_card.dart';
import 'package:nhameii/components/homepage_component/header_home_page.dart';
import 'package:nhameii/components/homepage_component/seemore_button.dart';
import 'package:nhameii/components/navigation_bar/nav_wrapper.dart';
import 'package:nhameii/components/cards/promo_card.dart';
import '../components/cards/food_card.dart';
import '../components/gradient_background.dart';
import 'package:nhameii/components/homepage_component/popular_restaurant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> foodCards = [
      FoodCard(
        title: 'Fish Amok',
        price: '\$4.99',
        imageUrl: 'assets/images/food/khmer/amok.png',
        // category: 'Khmer Food',
      ),
      FoodCard(
        title: 'Bok Kapi',
        price: '\$4.99',
        imageUrl: 'assets/images/food/khmer/bokkapii.png',
        // category: 'Khmer Food',
      ),
      FoodCard(
        title: 'Grilled Fish',
        price: '\$4.99',
        imageUrl: 'assets/images/food/khmer/fishang.png',
        // category: 'Khmer Food',
      ),
      FoodCard(
        title: 'Somlor Korko',
        price: '\$4.99',
        imageUrl: 'assets/images/food/khmer/kako.png',
        // category: 'Khmer Food',
      ),
      FoodCard(
        title: 'Koung',
        price: '\$4.99',
        imageUrl: 'assets/images/food/khmer/koung.png',
        // category: 'Khmer Food',
      ),
      FoodCard(
        title: 'Loklak',
        price: '\$4.99',
        imageUrl: 'assets/images/food/khmer/loklak.png',
        // category: 'Khmer Food',
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
    final List<Widget> popularRestaurants = [
      PopularRestaurant(imagePath: 'assets/images/restaurant/restaurant1.png', label: 'Khmer 24'),
      PopularRestaurant(imagePath: 'assets/images/restaurant/restaurant2.png', label: 'Malis'),
      PopularRestaurant(imagePath: 'assets/images/restaurant/restaurant3.png', label: 'Sakada'), 
      PopularRestaurant(imagePath: 'assets/images/restaurant/restaurant4.jpg', label: 'Sovanna Phum'),
      PopularRestaurant(imagePath: 'assets/images/restaurant/restaurant6.jpg', label: 'Khmer Food'),
      PopularRestaurant(imagePath: 'assets/images/restaurant/restaurant7.png', label: 'Angkor'),
      
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
                ), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderHomePage(),
                    const SizedBox(height: 26),
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
                      height: 280,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              foodCards
                                  .map(
                                    (card) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
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
                          children: [
                            ...categoryCard.map(
                              (ccard) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                child: ccard,
                              ),
                            ),
                            SeemoreButton(destination: Categorylist()),
                          ],
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
                    const SizedBox(height: 40),
                    
                    const Text(
                      'Popular Restaurants',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF44005E),
                      ),
                    ),
                    // const SizedBox(height: 20),
                    SizedBox(
                      height: 190,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              popularRestaurants
                                  .map(
                                    (restaurant) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      
                                      ),
                                      child: restaurant,
                                      
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), 
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
