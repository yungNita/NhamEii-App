import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nhameii/components/backbutton.dart';
import 'package:nhameii/components/cards/food_card.dart';
import 'package:nhameii/components/gradient_background.dart';
import 'package:nhameii/components/homepage_component/filterbutton.dart';
import 'package:nhameii/components/showRatingDialog.dart';

class RestaurantDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String rating;
  // final String location;
  // final 

  const RestaurantDetailPage({super.key, required this.id, required this.name, required this.rating});


  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  TextEditingController _searchController = TextEditingController();
  String searchText = '';
  String selectedCategory = 'Ice Cream';
  String ratingText = '';
  String subRatingText = '';
  bool isRated = false;
  String restName = '';
  String restRating = '';
  final restaurant = {
      'name': 'Bingoo IFL',
      'rating': '4',
      'location': 'Phnom Penh',
      'image': 'assets/images/brand1.png',
      'ratings': '600'
  };
  final rests = [
    {
      'id': 1,
      'name': 'Bingoo IFL',
      'rating': '4.5',
      'location': 'Phnom Penh',
      'image': 'assets/images/brand1.png',
      'categories': {
        'Ice Cream': [
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
          {
            'name': 'Sundae',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.5'
          },
        ],
        'Bucket': [
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
          {
            'name': 'Strawberry Girl',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '2.7'
          },
          {
            'name': 'Peach Bucket',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '3.00'
          },
        ],
        'Fruit Tea': [
          {
            'name': 'Lemonade Juice',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.2'
          },
          {
            'name': 'Jasmine Honey Tea',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '0.90'
          },
        ],
        'None Tea': [
          {
            'name': 'Lemonade Juice',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '1.2'
          },
          {
            'name': 'Jasmine Honey Tea',
            'image': 'assets/images/food/khmer/koung.png',
            'price': '0.90'
          },
        ],
      }
    }
  ];

  void _showRating() async {
    final rating = await showRatingDialog(context);
    if (rating != null) {
      setState(() {
         ratingText = 'You left a $rating star rating!🤩';
         subRatingText = 'Thanks for sharing with us!';
         isRated = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ratingText = 'Leave a rating';
    subRatingText = 'Tell others what you think!';
    restName = widget.name;
    restRating = widget.rating;
    _searchController.addListener(() {
      setState(() {
        searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = rests[0]['categories'] as Map<String, List<dynamic>>;
    final foodItems = searchText.isNotEmpty ?
      categories.entries
      .expand((entry) => entry.value)
      .where((item) => item['name'].toString().toLowerCase().contains(searchText))
      .toList()
      : categories[selectedCategory]!;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonWidget(),   
                SizedBox(height: 16),           
                // Restaurant Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/rest1.png' ,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12),
                // Name + Rating
                Text(
                  restName!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Row(
                      children: 
                      List.generate(5, (i) {
                        return Icon(
                          Icons.star,
                          color: i < int.parse(restRating) ? Colors.amber : Colors.grey[300],
                          size: 20,
                        );
                      },
                      ),
                    ),
                    Text('(${restaurant['ratings']}+)'),
                  ],
                ),
                SizedBox(height: 16),
                FilterButton(label: ratingText, isActive: isRated, 
                onPressed: (){
                  _showRating();
                }),
                SizedBox(height: 4),
                Text(subRatingText, style: TextStyle(color: CupertinoColors.inactiveGray, fontSize: 10),),
                SizedBox(height: 32),
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search menu...',
                    filled: true,
                    fillColor: Color(0xFFE9E9FF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(64),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(64),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Category Banner
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (searchText.isEmpty)
                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: categories.keys.map((category) {
                            final isSelected = category == selectedCategory;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FilterButton(
                                label: category, 
                                isActive: isSelected, 
                                onPressed: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                              }
                              )
                            );
                          }).toList(),
                        ),
                      )
                    else
                      SizedBox(
                        height: 40,
                        child: Text('Search Results'),
                      ),
                  
                    SizedBox(height: 16),
                  ],
                ),
                  
                // Food Grid
                Column(
                  children: foodItems.isNotEmpty ? _buildItemRows(foodItems) : [emptyResult()],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emptyResult() {
    return Center(
      child: Text("No results found"),
    );
  }

  List<Widget> _buildItemRows(List<dynamic> items) {
    List<Widget> rows = [];

    for (int i = 0; i < items.length; i += 2) {
      final item1 = items[i];
      final item2 = (i + 1 < items.length) ? items[i + 1] : null;

      rows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 25, 0),
          child: Row(
            children: [
              FoodCard(
                imageUrl: item1['image'], 
                title: item1['name'], 
                price: item1['price']
              ),
              SizedBox(width: 50),
              item2 != null
                  ? FoodCard(
                      imageUrl: item2['image'], 
                      title: item2['name'], 
                      price: item2['price']
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      );
    }

    return rows;
  }

}
  