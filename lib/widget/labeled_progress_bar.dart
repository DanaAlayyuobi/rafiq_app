import 'package:flutter/material.dart';

class LabeledProgressBar extends StatelessWidget {
  final String label;
  final double progress; // Progress value (0.0 to 1.0)
  final Color progressColor;

  const LabeledProgressBar({
    required this.label,
    required this.progress,
    this.progressColor = Colors.blue, // Default progress color
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8.0), // Space between label and progress bar
        SizedBox(
          width: 150,
          child: LinearProgressIndicator(
            value: progress, // Progress value
            backgroundColor: Colors.grey[300], // Background of the progress bar
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }
}
