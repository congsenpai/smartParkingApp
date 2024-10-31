import 'package:flutter/material.dart';

class StartWidget extends StatefulWidget {
  final int startNumber;
  final int evaluateNumber;

  const StartWidget({
    super.key,
    required this.startNumber,
    required this.evaluateNumber,
  });

  int get a => startNumber;
  int get b => evaluateNumber;

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
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