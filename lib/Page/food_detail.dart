import 'package:cloud_firestore/cloud_firestore.dart'
show FirebaseFirestore, FieldValue;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';

import '../components/background.dart';
import '../components/button.dart';

class FoodDetail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? detail;
  final String? rating;

  const FoodDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.detail,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/background3.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackButtonWidget(),
                      const SizedBox(height: 20),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: smartImage(
                            imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 120),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    rating ?? 'N/A',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        detail ?? 'No detail available.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GradientButton(
                            onPressed: () async {
                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  print('No user logged in!');
                                  return;
                                }

                                await FirebaseFirestore.instance
                                    .collection('history')
                                    .add({
                                      'userId': user.uid, 
                                      'title': title,
                                      'imageUrl': imageUrl,
                                      'price': price,
                                      'detail': detail ?? '',
                                      'rating': rating ?? '',
                                      'timestamp': FieldValue.serverTimestamp(),
                                    });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to history! 🍔'),
                                  ),
                                );
                              } catch (e) {
                                print('Error adding to history: $e');
                              }
                            },

                            text: 'Eat Now!',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget smartImage(
    String path, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
      );
    } else {
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
      );
    }
  }
}
