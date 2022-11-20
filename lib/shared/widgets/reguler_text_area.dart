import 'package:flutter/material.dart';

class RegulerTextArea extends StatelessWidget {
  final InputDecoration inputDecoration;
  final bool obsecure;
  final Function(dynamic value) onChanged;
  final int maxLines;
  final String? value;

  const RegulerTextArea({
    super.key, 
    required this.inputDecoration, 
    required this.obsecure, 
    required this.onChanged,
    required this.maxLines,
    this.value});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obsecure,
      decoration: inputDecoration,
      onChanged: onChanged,
      initialValue: value,
    );
  }
}