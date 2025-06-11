import 'package:flutter/material.dart';

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
    required this.onSelected
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
        // boxShadow: [
        //   BoxShadow(
        //     color: Color.fromARGB(255, 218, 218, 218), // shadow color
        //     spreadRadius: 2,  // how much the shadow spreads
        //     blurRadius: 5,    // softness of the shadow
        //     offset: Offset(3, 3), // x, y offset of the shadow
        //   ),
        // ],
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
                  fontSize: 18,
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
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(Color(0xff2C3E50)),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text("Cancel"),
                  
                ),
                ElevatedButton(
                  onPressed: () {}, 
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xff868BFB)),
                    foregroundColor: WidgetStateProperty.all(Color(0xffffffff)),
                  ),
                  child: Text('Apply'),
                  
                ),
                  
              ],
            )
          ],
        ),
      ),
    );
  }
}



