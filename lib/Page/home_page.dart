import 'package:flutter/material.dart';
import 'package:nhameii/Page/account_section/wishlist_page.dart';
import 'package:nhameii/Page/categorylist.dart';
import 'package:nhameii/components/cards/category_card.dart';
import 'package:nhameii/components/homepage_component/header_home_page.dart';
import 'package:nhameii/components/homepage_component/seemore_button.dart';
import 'package:nhameii/components/navigation_bar/nav_wrapper.dart';
import 'package:nhameii/components/cards/promo_card.dart';
import '../components/cards/food_card.dart';
import '../components/gradient_background.dart';
import '../data/food_image.dart';
import '../data/category_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  List<Map<String, dynamic>> wishlistItems = [];

  void toggleWishlist(Map<String, dynamic> item) {
    setState(() {
      if (wishlistItems.any((element) => element['id'] == item['id'])) {
        wishlistItems.removeWhere((element) => element['id'] == item['id']);
      } else {
        wishlistItems.add(item);
      }
    });
  }

  final List<Widget> promoCards = [
    PromoCard(imagePath: 'assets/promo1.jpg'),
    PromoCard(imagePath: 'assets/promo1.jpg'),
    PromoCard(imagePath: 'assets/promo1.jpg'),
    PromoCard(imagePath: 'assets/promo1.jpg'),
    PromoCard(imagePath: 'assets/promo1.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 0, //current index for HomePage
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
           floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistPage(wishlistItems: wishlistItems),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          ),
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
                      child: StreamBuilder<QuerySnapshot>(
                        stream:
                            FirebaseFirestore.instance
                                .collection('foods')
                                .where('categoryId', isEqualTo:  'khmer-food')
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final food = snapshot.data!.docs;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  food.map((doc) {
                                    final data =
                                        doc.data() as Map<String, dynamic>;
                                    final foodId = doc.id;
                                    final title = data['name'] ?? '';
                                    final price =
                                        data['price']?.toString() ?? '';
                                    final imageUrl = foodImages[foodId] ?? '';
                                    final rating = data['rating'].toString();
                                    final detail = data['detail'];

                                    final isWishlisted = wishlistItems
                                    .any((item) => item['id'] == foodId);
                                    
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: FoodCard(
                                        imageUrl: imageUrl,
                                        title: title,
                                        price: '\$$price',
                                        detail: detail,
                                        rating: rating,
                                        isInitiallyWishlisted: isWishlisted, id: '',
                                      ),
                                    );
                                  }).toList(),
                            ),
                          );
                        },
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
                      child: StreamBuilder<QuerySnapshot>(
                        stream:
                            FirebaseFirestore.instance
                                .collection('categories')
                                .where('type', arrayContains: 'Trending')
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No categories found"),
                            );
                          }
                          final categories = snapshot.data!.docs;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...categories.map((doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  final title = data['title'] as String? ?? '';
                                  final categoryId = doc.id;
                                  final types = List<String>.from(
                                    data['type'] ?? [],
                                  );
                                  final imagePath =
                                      categoryImages[categoryId] ?? '';

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0,
                                    ),
                                    child: CategoryCard(
                                      title: title,
                                      imagePath: imagePath,
                                      type: types,
                                    ),
                                  );
                                }),
                                SeemoreButton(destination: Categorylist()),
                              ],
                            ),
                          );
                        },
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
                    const SizedBox(height: 70), // extra space at bottom
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
