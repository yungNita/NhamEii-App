import 'package:flutter/material.dart';
import '../../Page/food_detail.dart';


class FoodCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const FoodCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetail(
              imageUrl: imageUrl,
              title: title,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        width: 122,
        height: 160,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.55, 1.0],
            colors: [Color(0xFFFFFFFF), Color(0xFFEDEDF9), Color(0xFFF4E3F2)],
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(35),
            bottom: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFEAD3EA),
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -90,
              left: -15.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Image.asset(imageUrl, width: 120, height: 120),
                ),
              ),
            ),
            Positioned.fill(
              top: 47,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: RichText(
                      text: TextSpan(
                        text: title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF44005E),
                          height: 1.5,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEB1E63),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
