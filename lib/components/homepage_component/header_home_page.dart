import 'package:flutter/material.dart';
import 'package:nhameii/Page/game_page.dart';
import 'package:nhameii/Page/question_answer.dart';
import 'package:nhameii/components/button.dart';
import 'package:nhameii/components/homepage_component/promotion.dart';
import 'package:nhameii/components/options.dart';
import 'package:nhameii/components/search.dart';

import 'header.dart';
import 'searchbar.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of promotions for easier management and spacing
    const promotions = [
      {'image': 'assets/images/image1.png', 'label': 'Offers'},
      {'image': 'assets/images/image2.png', 'label': 'Restaurant'},
      {'image': 'assets/images/image3.png', 'label': 'Buffet'},
      {'image': 'assets/images/image4.png', 'label': 'Dessert'},
      {'image': 'assets/images/image5.png', 'label': 'Beverages'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(),
        const SizedBox(height: 10),
        const Text(
          'អត់ដឹងញុាំអីែមន',
          style: TextStyle(fontSize: 22, fontFamily: 'Kh BL LazySmooth'),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.only(right:16), 
          child: Row(
          children: [
            Search(),
            const SizedBox(width: 8),
            
          ],
        ),),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                promotions.map((promo) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Promotions(
                      imagePath: promo['image']!,
                      label: promo['label']!,
                      onTap: null,
                    ),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        Options(
          title: 'Spin the wheel to get a suggestion!',
          buttonText: 'Spin!!',
          imageAsset: 'assets/images/wheel.png',
          image: 'assets/images/peng.png',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage()));
          },
        ),
        const SizedBox(height: 20),
        Options(
          title: 'Answer questions for suggestions!',
          buttonText: 'Start!!',
          imageAsset: 'assets/images/qna.png',
          image: 'assets/images/peng2.png',
          imageLeft: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => QnAFlowPage()));
          },
        ),
      ],
    );
  }
}