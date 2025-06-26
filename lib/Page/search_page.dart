import 'package:flutter/material.dart';
import 'package:nhameii/Page/categorylist.dart';
import 'package:nhameii/Page/restaurant_page.dart';
import 'package:nhameii/Page/search_results_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nhameii/components/gradient_background.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> recentSearches = ['Pizza', 'Sushi', 'Potato'];
  final List<String> fakeQueryResults = ['Pizza Hut', 'Sushi Chef', 'Pizza Corner'];
  final List<Map<String, String>> foodItems = [
    {
      'restaurantName': 'Burger King',
      'itemName': 'Burger',
      'price': '6.99',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/plate.png',
    },
    {
      'restaurantName': 'Sushi Chef',
      'itemName': 'Salmon Rice',
      'price': '6.99',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/plate.png',
    },
    {
      'restaurantName': 'Hel Corner',
      'itemName': 'Bok lahong',
      'price': '6.99',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/plate.png',
    },
    {
      'restaurantName': 'Potato Corner',
      'itemName': 'Truffle fries',
      'price': '6.99',
      'rating': '4.5',
      'description': 'Rice with veggies and fresh salmon',
      'imageUrl': 'assets/images/plate.png',
    },
  ];
  String query = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        query = _controller.text;
      });
    });
  }

  void onSearchSubmitted(String value) {
    if(value.trim().isEmpty) return;

    // Add to recent search if not already there
    if(!recentSearches.contains(value)) {
      setState(() { 
        recentSearches.insert(0, value);
        if(recentSearches.length > 5) recentSearches.removeLast();
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SearchResultsPage(query: value))
    );
  }

  void deleteSearch(String value) {
    if(recentSearches.contains(value)) {
      // var index = recentSearches.indexOf(value);
      setState(() {
        recentSearches.remove(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isTyping = query.isNotEmpty;

    return Scaffold(
      body: GradientBackground(
        child: Scaffold(
          // appBar: AppBar(title: Text("Search")),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    // Back button
                  IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    icon: SvgPicture.asset('assets/icons/backarrow.svg', width: 24, height: 24)
                  ),
                // Search bar
                Flexible(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: onSearchSubmitted,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 14, right: 8),
                        child: Icon(Icons.search),
                      ),
                      prefixIconColor: Color(0xff9796C0),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color(0xff9796C0),
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(64),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(64),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                      ),
                      filled: true,
                      fillColor: Color(0xFFE9E9FF),
                    ),
                  ),
                ),
                  ],
                ),
                SizedBox(height: 16),
                // Dynamic body based on typing
                Expanded(
                  child: isTyping ? buildQueryResults() : buildRecentSearches(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Searches", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        ...recentSearches.map((item) => ListTile(
          contentPadding: EdgeInsets.all(0),
          minVerticalPadding: 0,
          dense: true,
          onTap: () => onSearchSubmitted(item),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/history.svg'),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(item),
              ),
              Spacer(),
              IconButton(
                onPressed: () { 
                  setState(() {
                    deleteSearch(item);
                  });
                  }, 
                icon:  SvgPicture.asset('assets/icons/cross.svg'),
                )
            ],
          ),
        )),
        SizedBox(height: 24),
        Row(
          children: [
            Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Categorylist())),
              child: Text(
                  "View All", 
                  style: TextStyle( fontWeight: FontWeight.w500, fontSize: 12),
                  ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Text("Restaurants", style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantPage())),
              child: Text("View All", style: TextStyle( fontWeight: FontWeight.w500, fontSize: 12))
            )
          ],
        ),
        
      ],
    );
  }

  Widget buildQueryResults() {
    List<String> filtered = fakeQueryResults
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filtered.isEmpty
        ? Center(
          child: Column(
            children: [
              // SvgPicture.asset('assets/icons/observed.svg'),
              Text("No results found."),
            ],
          ))
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search results", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 25, top:0, bottom: 0, right: 0),
                        minVerticalPadding: 0,
                        dense: true,
                        title: Text(filtered[index]),
                        onTap: () => onSearchSubmitted(filtered[index]),
                      ),
                    );
                  },
                ),
            ),
          ],
        );
  }

}