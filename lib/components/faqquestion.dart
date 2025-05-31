import 'package:flutter/material.dart';

class FaqQuestion extends StatefulWidget {
  final String question;
  final String answer;

  const FaqQuestion({Key? key, required this.question, required this.answer})
    : super(key: key);

  @override
  State<FaqQuestion> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqQuestion> {
  bool _isOpen = false;

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        InkWell(
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  _isOpen ? Icons.remove : Icons.add,
                  color: Color(0xFF3E0061),
                ),
              ],
            ),
          ),
        ),
        if (_isOpen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              widget.answer,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        const Divider(thickness: 1.0),
      ],
    );
  }
}
