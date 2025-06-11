import 'package:flutter/material.dart';

class SeemoreButton extends StatelessWidget {
  final Widget destination;

  const SeemoreButton({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        shape: const CircleBorder(),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: const Icon(Icons.navigate_next_rounded),
    );
  }
}
