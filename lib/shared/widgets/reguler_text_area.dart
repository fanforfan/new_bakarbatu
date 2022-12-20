import 'package:flutter/material.dart';

class RegulerTextArea extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration inputDecoration;
  final bool obsecure;
  final Function(dynamic value) onChanged;
  final int maxLines;
  final String? value;

  const RegulerTextArea({
    super.key,
    this.controller,
    required this.inputDecoration, 
    required this.obsecure, 
    required this.onChanged,
    required this.maxLines,
    this.value});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      obscureText: obsecure,
      decoration: inputDecoration,
      onChanged: onChanged,
      initialValue: value,
    );
  }
}