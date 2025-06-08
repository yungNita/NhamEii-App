import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String imagePath;

  const PromoCard({
    super.key,
    required this.imagePath,
  }); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
    );
  }
}

class PromotionSection extends StatelessWidget {
  final List<String> imagePaths;
  const PromotionSection({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return PromoCard(imagePath: imagePaths[index]);
        },
      ),
    );
  }
}