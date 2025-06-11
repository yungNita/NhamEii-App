import 'package:flutter/material.dart';
import 'package:nhameii/components/background.dart';
import 'package:nhameii/components/cards/category_card.dart';
import 'package:nhameii/components/homepage_component/filterbutton.dart';
import 'package:nhameii/components/homepage_component/header.dart';
import 'package:nhameii/components/navigation_bar/nav_bar.dart';

import '../data/categoryitem.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({super.key});

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  int selectedIndex = 0;

  final List<String> filters = [
    'All',
    'Trending',
    'Asian',
    'Western',
    'Italian',
    'Snack',
    'Dessert',
    'Beverages',
    'Street Food',
    'Fast Food',
    'Healthy Food',
    'Halal',
    'Vegetarian',
    'Vegan',
    'Seafood',
    'Meat',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<CategoryCard> allCards = allCategoryCards;

    // Apply filter
    final String selectedType = filters[selectedIndex];
    final List<CategoryCard> filteredCards =
        selectedType == 'All'
            ? allCards
            : allCards
                .where((card) => card.type.contains(selectedType))
                .toList();

    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(),
            SizedBox(height: 20),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Categories',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return FilterButton(
                    label: filters[index],
                    isActive: selectedIndex == index,
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children:
                        filteredCards
                            .map((ccard) => SizedBox(width: 130, child: ccard))
                            .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 0, onTap: (index) {}),
    );
  }
}
