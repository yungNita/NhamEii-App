import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nhameii/components/filterCard.dart';
import 'package:nhameii/components/foodCard02.dart';
import 'package:nhameii/components/gradient_background.dart';
import 'package:nhameii/components/homepage_component/filterbutton.dart';
import 'package:nhameii/components/navigation_bar/nav_wrapper.dart';


class SearchResultsPage extends StatefulWidget {
  final String query;
  const SearchResultsPage({super.key, required this.query});

  @override
  _SearchResultsPage createState() => _SearchResultsPage();
}

class _SearchResultsPage extends State<SearchResultsPage> {
  String chosenValue = '';
  // String chosenRating = '';
  int selectedIndex = 0;
  String selectedOp = '';
  List<String> filterOps = ['All', 'Price', 'Rating'];
  // Sample dummy data
  List<List<String>> filterArrays = [
    [],
    ['Low-High', 'High-Low'],
    ['5.0', '4.0', '3.0']
  ];
  List <Map<String, String>> displayRes = [];
    final List <Map<String, String>>results = [
    {
      'restaurantName': 'Burger King',
      'itemName': 'Burger',
      'price': '6.9',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Sushi Chef',
      'itemName': 'Salmon Rice',
      'price': '3',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Hel Corner',
      'itemName': 'Bok lahong',
      'price': '5',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Potato Corner',
      'itemName': 'Truffle fries',
      'price': '1',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Burger King',
      'itemName': 'Burger',
      'price': '23',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Sushi Chef',
      'itemName': 'Salmon Rice',
      'price': '9',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Hel Corner',
      'itemName': 'Bok lahong',
      'price': '6',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
    {
      'restaurantName': 'Potato Corner',
      'itemName': 'Truffle fries',
      'price': '7',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/food/khmer/kako.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      displayRes = results;
    });
  }

  List<Map<String, String>> sortResults(String value) {
    var filteredRes = results;
    // sort by price
    switch (value) {
      case "Low-High":
      // Sort by price (ascending)
      filteredRes.sort((a, b) => double.parse(a['price']!).compareTo(double.parse(b['price']!)));
      break;
      case "High-Low":
      filteredRes.sort((a, b) => double.parse(b['price']!).compareTo(double.parse(a['price']!)));
      break;
    }

    if(double.tryParse(value) != null) {
      // filter by rating
      filteredRes = results.where((item) {
        double? ratingValue = double.tryParse(item['rating']!);
        var minRating = double.parse(value);
        return ratingValue != null && ratingValue >= minRating && ratingValue < minRating+1;
      }).toList();
    }
    return filteredRes;
  }

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 0,
      child: GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                    children: [
                      // Back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: SvgPicture.asset('assets/icons/backarrow.svg', width: 24, height: 24)
                    ),
                    Text("${results.length} results for \"${widget.query}\"")
                    ]
                ),

                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    itemCount: filterOps.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      return FilterButton(
                        label: selectedIndex == index && filterArrays[index].contains(chosenValue)? "${filterOps[index]}: $chosenValue": filterOps[index],
                        isActive: selectedIndex == index,
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                            if (selectedIndex == 0) {
                              displayRes = results;
                            }
                          });

                          if (selectedIndex != 0) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Dialog(
                                  child: FilterCard(
                                    name: filterOps[index],
                                    options: filterArrays[index],
                                    onSelected: (value) { // emitted part
                                      setState(() {
                                        chosenValue = value;  // got the chosen sort value option
                                        print(chosenValue);
                                        displayRes = sortResults(chosenValue);
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),

                Expanded(
                  child: displayRes.isNotEmpty ? buildFoundResults() : resultsNotFound()
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
    );
  }

  Widget buildFoundResults() {
    return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: displayRes.length,
            itemBuilder: (context, index) {
              var item = displayRes[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FoodCard02(
                      restaurantName: item["restaurantName"] ?? 'Sushi Chef', 
                      rating: item["rating"] ?? '4.5', 
                      itemName: item["itemName"] ?? 'Chicken Salad', 
                      description: item["description"] ?? 'Fresh veggies and customized salad dressing', 
                      price: item["price"] ?? "2.5", 
                      imageUrl: item["imageUrl"] ?? 'assets/images/food/khmer/kako.png'
                    ),
                  ),
                ],
              );
            },
          );
  }

  Widget resultsNotFound() {
    return Text("No results found");
  }
}