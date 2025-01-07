import 'package:flutter/material.dart';

class DropdownNumberWidget extends StatelessWidget {
  final int? selectedValue;
  final Function(int?) onChanged;
  final String hintText;
  final List<int> values = List.generate(11, (index) => index);

  DropdownNumberWidget({
    super.key,
    this.selectedValue,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 119,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7), // Rounded edges
        border: Border.all(color: Colors.grey), // Border color
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        child: DropdownButton<int>(
          isDense: true, // Ensures that the dropdown takes up less space
          value: selectedValue,
          hint: Text(hintText),
          items: values.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          underline:
          const SizedBox(), // Removes the default underline of the dropdown
        ),
      ),
    );
  }
}
