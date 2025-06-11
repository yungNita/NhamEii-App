import 'package:flutter/material.dart';
import 'package:nhameii/components/background.dart';
import 'package:nhameii/components/cards/food_card.dart';
import 'package:nhameii/components/homepage_component/header.dart';
import 'package:nhameii/data/fooditem.dart';

class FoodlistBycategory extends StatefulWidget {
  final String title;

  const FoodlistBycategory({super.key, required this.title});

  @override
  State<FoodlistBycategory> createState() => _FoodlistBycategoryState();
}

class _FoodlistBycategoryState extends State<FoodlistBycategory> {
  late List<Map<String, String>> filteredFoodItems;

  @override
  void initState() {
    super.initState();
    filteredFoodItems =
        allFoodItems.where((item) => item['category'] == widget.title).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            Header(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 60,
                  horizontal: 20,
                ),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 40, // Horizontal space between cards
                  runSpacing: 80, // Vertical space between rows
                  children:
                      filteredFoodItems.map((item) {
                        return SizedBox(
                          width: 130,
                          child: FoodCard(
                            imageUrl: item['imageUrl'] ?? '',
                            title: item['title'] ?? '',
                            price: item['price'] ?? '',
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
