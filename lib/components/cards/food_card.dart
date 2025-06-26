import 'package:flutter/material.dart';
import 'package:nhameii/Page/food_detail.dart';

class FoodCard extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final String? detail;
  final String? rating;
  final bool isInitiallyWishlisted;

  const FoodCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.detail,
    this.rating,
    this.isInitiallyWishlisted = false,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late bool isWishlisted;

  @override
  void initState() {
    super.initState();
    isWishlisted = widget.isInitiallyWishlisted;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetail(
              imageUrl: widget.imageUrl,
              title: widget.title,
              price: widget.price,
              detail: widget.detail,
              rating: widget.rating,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
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
                top: -70,
                left: -5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: Image.asset(widget.imageUrl, width: 100, height: 100),
                  ),
                ),
              ),
              Positioned(
                top: -63,
                right: -25,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isWishlisted = !isWishlisted;
                    });
                    // You could add Firestore update here if needed
                  },
                  child: Image.asset(
                    isWishlisted
                        ? 'assets/icons/heart_fill.png'
                        : 'assets/icons/heart.png',
                    width: 24,
                    height: 24,
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
                          text: widget.title,
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
                      widget.price,
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
      ),
    );
  }
}