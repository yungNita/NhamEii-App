import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatelessWidget {
  final String searchItem;
  
  const Search({ super.key, this.searchItem = '' });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: (){ print("svg btn pressed");}, 
              icon: SvgPicture.asset('assets/icons/backarrow.svg', width: 24, height: 24)
            ),
            Expanded(child: TextField(
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2),
                ),
                filled: true,
                fillColor: Color(0xFFE9E9FF),
              ),
            ))
          ],
        ),
      ),
    );
  }
}