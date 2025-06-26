import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatelessWidget {
  final String searchItem;
  
  const Search({ super.key, this.searchItem = '' });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
          Navigator.pushReplacementNamed(context, '/search')
        },
        child: Container(
          width: 365,
          decoration: ShapeDecoration(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(64),
            // side: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2),
          )),
          
          clipBehavior: Clip.hardEdge,
          child: TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 14, right: 8),
                  child: Icon(Icons.search),
                ),
                prefixIconColor: Color(0xff9796C0),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Color(0xff9796C0),
                  fontWeight: FontWeight.bold,
                ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(64),
                //   borderSide: BorderSide(color: const Color.fromARGB(255, 97, 27, 27), width: 2),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(64),
                //   borderSide: BorderSide(color: const Color.fromARGB(255, 220, 72, 72), width: 2),
                // ),
                filled: true,
                fillColor: Color(0xFFE9E9FF),
              ),
            ),
          
        ),
      );
  }
}