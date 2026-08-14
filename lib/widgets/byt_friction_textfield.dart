import 'dart:async';
import 'package:flutter/material.dart';

class BytFrictionTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final VoidCallback onFrictionDetected;

  const BytFrictionTextField({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.onFrictionDetected,
  }) : super(key: key);

  @override
  State<BytFrictionTextField> createState() => _BytFrictionTextFieldState();
}

class _BytFrictionTextFieldState extends State<BytFrictionTextField> {
  Timer? _frictionTimer;

  // checking if 5 seconds passes without user input - display message
  void _resetTimer() {
    _frictionTimer?.cancel();
    _frictionTimer = Timer(const Duration(seconds: 5), () {
      widget.onFrictionDetected();
    });
  }

  // clean and build the ui
  @override
  void dispose() {
    _frictionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.timer_outlined),
      ),
      onChanged: (text) {
        _resetTimer();
        widget.onChanged(text);
      },
    );
  }
}