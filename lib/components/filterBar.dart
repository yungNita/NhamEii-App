import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nhameii/components/filterCard.dart';
import 'package:nhameii/components/foodCard02.dart';

// build a filter bar
// default is All
// other options like price and rating,
// when click, it shows another widget.
class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  _FilterBar createState() => _FilterBar();
}

class _FilterBar extends State<FilterBar> {
  String chosen = '';
  String chosenRating = '';
  int selectedIndex = 0;
  String selectedOp = '';
  List<String> filterOps = ['All', 'Price', 'Rating'];
  List<List<String>> filterArrays = [
    [],
    ['Low-High', 'High-Low'],
    ['5.0', '4.0', '3.0']
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Row(
            children: filterOps.map((option) {
              final index = filterOps.indexOf(option);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                      selectedOp = option;
                    });
                    
                    if (selectedIndex != 0) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return Dialog(
                            child: FilterCard(
                              name: option,
                              options: filterArrays[index],
                              onSelected: (value) {
                                setState(() {
                                  chosen = value;
                                });
                              },
                            ),
                          );
                        },
                      );
                    }

                      
                    
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'
                    ),
                    side: selectedIndex == index? null : BorderSide(
                      color: Color(0xff2C3E50),
                      width: 1
                    ),
                    backgroundColor: selectedIndex == index ? Color(0xff868BFB) : Color(0xffCED0FD),
                    foregroundColor: selectedIndex == index ? Colors.white : Color(0xff2C3E50),
                    
                  ),
                  child: index == 0 ? 
                  Text(option) : 
                  Row(
                    children: [
                      Text(option),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )
                ),  
              );
            }).toList(),
              
              // FilterCard(
              //   name: "Price",
              //   options: ['Low-High', 'High-Low'],
              //   onSelected: (value) {
              //     setState(() {
              //       chosen = value;
              //     });
              //   },
              // ),
              // Text('Selected: $chosen'),
            
          ),

          FoodCard02(
            restaurantName: 'Sushi Chef',
            itemName: 'Salmon Rice',
            price: '6.99',
            rating: '4.5',
            description: 'Rice with veggies and fresh salmon',
            imageUrl: 'assets/images/plate.png',
          )
        ],
      ),
    );
  }
}
