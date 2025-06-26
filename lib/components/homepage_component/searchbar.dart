import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const Searchbar({
    super.key,
    required this.onChanged,
    this.hintText = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/search');
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Color(0xFFE9E9FF),
        prefixIcon: Icon(Icons.search),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFFFFFFFF)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}