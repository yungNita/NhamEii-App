import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodCard02 extends StatefulWidget {
  final String restaurantName;
  final String rating;
  final String itemName;
  final String description;
  final String price;
  final String imageUrl;

  const FoodCard02({
    super.key,
    required this.restaurantName,
    required this.rating,
    required this.itemName,
    required this.description,
    required this.price,
    required this.imageUrl
    
  });

  @override
  State<FoodCard02> createState() => _FoodCard02State();
}

class _FoodCard02State extends State<FoodCard02> {
  

  
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // main box
        Column(
        children: [
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(100, 2, 16, 2),
            decoration: BoxDecoration(
              color: Color(0xff868BFB),
              borderRadius:BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/icons/house.svg'),
                Padding(
                  padding: const EdgeInsets.only( left: 8 ),
                  child: Text(
                    widget.restaurantName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),  
                  ),
                ),
                Spacer(),
                SvgPicture.asset('assets/icons/star.svg'),
                Text(
                  widget.rating,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),  
                )
              ],
            ),
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(

              color: Color(0xffE9E9FF),
              borderRadius:BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))

            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 6, 8, 8),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    style: TextStyle(
                      color: Color(0xff3E0061),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff3E0061),
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '\$${widget.price}',
                      style: TextStyle(
                        color: Color(0xffE10F66),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),

      //hovering img on the left
      Positioned(
        left: -30,
        top: -5,
        child: Container(
          width: 120,
          height: 120,
          child: Image.asset(widget.imageUrl),
          
        ),
      )
      ]
    );
  }
}