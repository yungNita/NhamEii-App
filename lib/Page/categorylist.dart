import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';
import 'package:nhameii/components/background.dart';
import 'package:nhameii/components/cards/category_card.dart';
import 'package:nhameii/components/homepage_component/filterbutton.dart';
import 'package:nhameii/components/homepage_component/header.dart';
import 'package:nhameii/components/navigation_bar/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/category_image.dart';
import '../data/categoryitem.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({super.key});

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  int selectedIndex = 0;
  List<String> filters = [];
  bool isLoadingFilters = true;

  @override
  void initState() {
    super.initState();
    _fetchFilters();
  }
  Future<void> _fetchFilters() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('filters')
          .get();

      final fetched = snapshot.docs.map((doc) => doc['name'] as String).toList();

      setState(() {
        filters = fetched; 
        isLoadingFilters = false;
      });
    } catch (e) {
      print('Error loading filters: $e');
      setState(() {
        isLoadingFilters = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

  if (isLoadingFilters || filters.isEmpty) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

    return 
    Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header(),
            SizedBox(height: 20),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BackButtonWidget(),
                    SizedBox(width: 10),
                    Text(
                      'Categories',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
             isLoadingFilters
                ? const Center(child: CircularProgressIndicator())
                :
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
              child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('categories').snapshots(), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('no categories'),);
                }
                final categories = snapshot.data!.docs.map((doc) {
                   final data = doc.data() as Map<String, dynamic>;
                    final categoryId = doc.id;
                    final title = data['title'] as String? ?? '';
                    final types = List<String>.from(data['type'] ?? []);
                    final imagePath = categoryImages[categoryId] ?? '';

                    return CategoryCard(
                      title: title,
                      imagePath: imagePath,
                      type: types,
                    );
                }).toList();

                final String selectedType = filters[selectedIndex];
                final filteredCategories = selectedType == 'All' ? categories : categories.where((card) => card.type.contains(selectedType)).toList();
                 return SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.only(left: 0.0),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children:
                        filteredCategories
                            .map((ccard) => SizedBox(width: 130, child: ccard))
                            .toList(),
                  ),
                ),
              );})
            ),
          ],
        ),
      ),
      
    );
  
  }
}
