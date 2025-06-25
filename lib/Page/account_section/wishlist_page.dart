import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';
import 'package:nhameii/components/cards/food_card.dart';

class WishlistPage extends StatefulWidget {
  final List<Map<String, dynamic>> wishlistItems;

  const WishlistPage({super.key, required this.wishlistItems});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 15, left: 15),
            child: Row(
              children: [
                const BackButtonWidget(),
                const SizedBox(width: 8),
                Text(
                  'Wishlist',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.wishlistItems.isEmpty
                ? const Center(child: Text('No items in wishlist'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: widget.wishlistItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.wishlistItems[index];
                      return FoodCard(
                        id: item['id'],
                        imageUrl: item['imageUrl'],
                        title: item['title'],
                        price: item['price'],
                        detail: item['detail'],
                        rating: item['rating'],
                        isInitiallyWishlisted: true,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}