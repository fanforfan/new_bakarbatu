import 'package:flutter/material.dart';

class RegulerTextArea extends StatelessWidget {
  final InputDecoration inputDecoration;
  final bool obsecure;
  final Function(dynamic value) onChanged;

  const RegulerTextArea({
    super.key, 
    required this.inputDecoration, 
    required this.obsecure, 
    required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 7,
      obscureText: obsecure,
      decoration: inputDecoration,
      onChanged: onChanged,
    );
  }
}