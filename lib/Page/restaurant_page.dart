import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nhameii/Page/restaurant_detail_page.dart';
import 'package:nhameii/components/filterCard.dart';
import 'package:nhameii/components/gradient_background.dart';
import 'package:nhameii/components/homepage_component/filterbutton.dart';
import 'package:nhameii/components/restaurantCard.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List <Map<String, String>> displayRests = [];
  final rests = [
    {
      'name': 'Taco Bell',
      'rating': '4',
      'location': 'Phnom Penh'
    },
    {
      'name': 'Yellow Cab',
      'rating': '4',
      'location': 'Phnom Penh'
    },
    {
      'name': 'Snow Yogurt',
      'rating': '4',
      'location': 'Phnom Penh'
    },
    {
      'name': 'Matcha Venture',
      'rating': '4',
      'location': 'Phnom Penh'
    },
    {
      'name': 'Hotpot Lamb',
      'rating': '3',
      'location': 'Phnom Penh'
    },
    {
      'name': 'Apple Donuts',
      'rating': '5',
      'location': 'Phnom Penh'
    },
    {
      'name': 'Suki Soup',
      'rating': '3',
      'location': 'Phnom Penh'
    },
    {
      'name': 'ToTo Cafe',
      'rating': '5',
      'location': 'Phnom Penh'
    },
  ];
  List<String> filterOps = ['All', 'Rating'];
  // Sample dummy data
  List<List<String>> filterArrays = [
    [],
    ['5.0', '4.0', '3.0']
  ];
  int selectedIndex = 0;
  String chosenValue = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      displayRests = rests;
    });
  }

  List<Map<String, String>> sortResults(String value) {
    var filteredRests = rests;

    if(double.tryParse(value) != null) {
      // filter by rating
      filteredRests = rests.where((item) {
        double? ratingValue = double.tryParse(item['rating']!);
        var minRating = double.parse(value);
        return ratingValue != null && ratingValue >= minRating && ratingValue < minRating+1;
      }).toList(); 
    }
    return filteredRests;
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
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
                Text("${rests.length} restaurants")
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
                        if(selectedIndex == 0) {
                          displayRests = rests;
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
                                    displayRests = sortResults(chosenValue);
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
              child: displayRests.isNotEmpty? buildFoundResults() : resultsNotFound()
            ),
          ],
        )
      ),
    );
  }

  Widget buildFoundResults() {
    return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: displayRests.length,
            itemBuilder: (context, index) {
              var item = displayRests[index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailPage(id: 1, name: item['name']!, rating: item['rating']!,))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RestaurantCard(
                        name: item['name'] ?? 'Hello world',
                        rating: item['rating'] ?? '0.0',
                        location: item['location'] ?? 'Phnom Penh',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget resultsNotFound() {
    return Text("No results found");
  }
}