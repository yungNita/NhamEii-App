import 'package:flutter/material.dart';
import 'package:nhameii/components/homepage_component/filterbutton.dart';

Future<int?> showRatingDialog(BuildContext context) {
  return showDialog<int>(
    context: context,
    builder: (context) => _RatingDialog(),
  );
}

class _RatingDialog extends StatefulWidget {
  @override
  State<_RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<_RatingDialog> {
  int _selectedRating = 0;

  void _setRating(int index) {
    setState(() {
      _selectedRating = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate this item'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return IconButton(
            iconSize: 36,
            onPressed: () => _setRating(index + 1),
            icon: Icon(
              Icons.star,
              color: index < _selectedRating ? Colors.amber : Colors.grey[400],
            ),
          );
        }),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        SizedBox(
          width: 100,
          child: FilterButton(
            label: 'Submit', 
            isActive: true, 
            onPressed: () => Navigator.of(context).pop(_selectedRating),),
        ),
      ],
    );
  }
}
