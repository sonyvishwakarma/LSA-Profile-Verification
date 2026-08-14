import 'package:flutter/material.dart';

class BytLineageTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;

  const BytLineageTextField({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: 'e.g., PRE-88102-XYZ',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.link_outlined),
      ),
      onChanged: onChanged,
    );
  }
}