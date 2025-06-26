import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:nhameii/components/gradient_background.dart';
import '../components/navigation_bar/nav_wrapper.dart';
import '../components/cards/history_card.dart';
import '../Page/food_detail.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userId = user?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 3,
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.only(
                    top: 36,
                    right: 22,
                    left: 13,
                    bottom: 10,
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 10),
                      Text(
                        'History Log',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF44005E),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: userId == null
                      ? const Center(child: CircularProgressIndicator())
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('history')
                              .where('userId', isEqualTo: userId)
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  'Something went wrong \nPlease try again later.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            final rawDocs = snapshot.data?.docs ?? [];

                            // Filter out broken or missing data
                            final validDocs = rawDocs.where((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              return data.containsKey('timestamp') && data.containsKey('title');
                            }).toList();

                            if (validDocs.isEmpty) {
                              return const Center(
                                child: Text('No history yet '),
                              );
                            }

                            // Group by date
                            final Map<String, List<QueryDocumentSnapshot>> grouped = {};
                            for (var doc in validDocs) {
                              final data = doc.data() as Map<String, dynamic>;
                              final timestamp = (data['timestamp'] as Timestamp).toDate();
                              final dateStr = DateFormat('dd MMM yyyy').format(timestamp);
                              grouped.putIfAbsent(dateStr, () => []).add(doc);
                            }

                            return ListView(
                              padding: const EdgeInsets.only(top: 8),
                              children: grouped.entries.map((entry) {
                                final date = entry.key;
                                final items = entry.value;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Text(
                                        date,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF44005E),
                                        ),
                                      ),
                                    ),
                                    ...items.map((doc) {
                                      final data = doc.data() as Map<String, dynamic>;
                                      return HistoryCard(
                                        imagePath: data['imageUrl'] ?? '',
                                        title: data['title'] ?? '',
                                        subtitle: data['detail'] ?? '',
                                        price: data['price'] ?? '',
                                        rating: data['rating'] ?? '',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => FoodDetail(
                                                imageUrl: data['imageUrl'] ?? '',
                                                title: data['title'] ?? '',
                                                price: data['price'] ?? '',
                                                detail: data['detail'] ?? '',
                                                rating: data['rating'] ?? '',
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
