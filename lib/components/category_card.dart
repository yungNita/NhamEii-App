import 'package:flutter/material.dart';

import '../Page/foodlist_bycategory.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<String> type;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.type,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => FoodlistBycategory(title: title),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: SizedBox(
          width: 122,
          height: 155,
          child: Column(
            children: [
              SizedBox(
                height: 122,
                width: double.infinity,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),

              // text
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44005E),
                    ),
                    textAlign: TextAlign.center,
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
