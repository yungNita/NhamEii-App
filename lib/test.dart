import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/button.dart';
import 'components/header.dart';
import 'components/options.dart';
import 'components/promotions.dart';
import 'components/searchbar.dart';

class TestComponent extends StatelessWidget {
  const TestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    const promotions = [
      {'image': 'assets/images/image1.png', 'label': 'Offers'},
      {'image': 'assets/images/image2.png', 'label': 'Restaurant'},
      {'image': 'assets/images/image3.png', 'label': 'Buffet'},
      {'image': 'assets/images/image4.png', 'label': 'Dessert'},
      {'image': 'assets/images/image5.png', 'label': 'Beverages'},
    ];

    return Background(
      child: SafeArea(
        child: Scaffold(
          appBar: Header(),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'អត់ដឹងញុាំអីែមន',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Kh BL LazySmooth',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Searchbar(onChanged: (query) {})),
                      const SizedBox(width: 8),
                      GradientButton(
                        imageAsset: 'assets/images/settings.png',
                        onPressed: () {
                          debugPrint('Filter button pressed');
                        },
                        width: 55,
                      ),
                    ],
                  ),
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
                    onPressed: () {
                      print('Option 1 clicked');
                    },
                  ),
                  const SizedBox(height: 20),
                  Options(
                    title: 'Answer questions for a recommendation!',
                    buttonText: 'Start!!',
                    imageAsset: 'assets/images/qna.png',
                    onPressed: () {
                      print('Option 2 clicked');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
