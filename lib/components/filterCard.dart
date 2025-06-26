import 'package:flutter/material.dart';
import 'package:nhameii/components/button.dart';

// build a widget to take a name and an array of options
// options are displayed to be selected
// selected option is sent back out.
class FilterCard extends StatefulWidget {
  final String name;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const FilterCard({
    super.key,
    required this.name,
    required this.options,
    required this.onSelected,
    });

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.fromARGB(255, 218, 218, 218),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      padding: EdgeInsets.all(18),
      width: 250,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  spacing: 0,
                  children: widget.options.map((option) {
                    final isSelected = option == selected;
                    return ChoiceChip(
                      label: Text(option), 
                      selected: isSelected,
                      labelStyle: TextStyle(fontSize: 10),
                      
                      onSelected: (_) {
                        setState(() {
                          selected = option;
                        });
                        widget.onSelected(option);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // widget.onApplied(false);
                    // print('cancel');
                    Navigator.of(context).pop(); // closes the dialog
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(Color(0xff2C3E50)),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text("Cancel", style: TextStyle(fontSize: 10),),
                  
                ),
                GradientButton(
                  onPressed: () {
                    // widget.onApplied(true);
                    widget.onSelected(selected!);
                    Navigator.of(context).pop(); // closes the dialog
                  },
                  text: "Apply",
                  textStyle: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
                ) 
              ],
            )
          ],
        ),
      ),
    );
  }
}



