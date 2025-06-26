import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_border/dotted_border.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String rating;
  final String location;
  const RestaurantCard({super.key, required this.name, required this.rating, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.0,
        height: 206.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
           boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 174, 174, 174),
                blurRadius: 10,
                offset: Offset(0, 4), // X, Y offset
              ),
            ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/rest1.png', 
            width: 300, 
            height: 120, 
            fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/star.svg'),
                          Text(rating, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,)),
                          Text("(600+)",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: const Color.fromARGB(255, 105, 105, 105)))
                        ],
                      )
                      
                    ],
                  ),
                  Text(location, style: TextStyle(fontSize: 10, color: const Color.fromARGB(255, 105, 105, 105)),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                    child: DottedBorder(
                      dashPattern: [4, 2], // 6 = dash length, 3 = space
                      strokeWidth: 1,
                      color: const Color.fromARGB(255, 217, 216, 216),
                      customPath: (size) {
                        return Path()
                        ..moveTo(0, 0)
                        ..lineTo(280, 0);
                      },
                      child: SizedBox(
                        height: 1, // no content height
                        width: 100, // full width
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Color(0xffffdbda),
                      borderRadius:BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/promotion.svg'),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text("12% off selected items", 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 9, 
                                    color: Color(0xffE10F66),
                                  ),
                                  ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            
          ],
        ),
      );
  }
}