import 'package:flutter/material.dart';

class StarWidget extends StatefulWidget {
  final int startNumber;
  final int evaluateNumber;

  const StarWidget({
    super.key,
    required this.startNumber,
    required this.evaluateNumber,
  });

  int get a => startNumber;
  int get b => evaluateNumber;

  @override
  State<StarWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            i < widget.a ? Icons.star : Icons.star_border, // Sao đầy đủ hoặc sao viền
            color: Colors.orange,
            size: 16,
          ),
        const SizedBox(width: 8),
        Text('${widget.b}'), // Hiển thị evaluateNumber
      ],
    );
  }
}