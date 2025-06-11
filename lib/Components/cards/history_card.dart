import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String date;

  const HistoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card
          Container(
            height: cardHeight,
            margin: const EdgeInsets.only(left: 50),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFF5E8FF), Color(0xFFEDE4FB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 60), //  creates space for the image
                // Info section
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Text(subtitle,
                          style: TextStyle(color: Colors.grey[600], fontSize: 10)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(date,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
                //Button
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD60059),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Eat again',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          //  Image aligned left and stretched to card height
          Positioned(
            left: 0,
            top: 0,
            child: ClipOval(
              child: Container(
                width: cardHeight + 8,
                height: cardHeight + 10 ,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                  fit: BoxFit.cover, //this fills the circle perfectly
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
