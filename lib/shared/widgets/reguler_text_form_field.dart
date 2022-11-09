import 'package:flutter/material.dart';

class RegulerTextFormField extends StatelessWidget {
  final InputDecoration inputDecoration;
  final bool obsecure;
  final Function(dynamic value) onChanged;

  const RegulerTextFormField({
    super.key, 
    required this.inputDecoration, 
    required this.obsecure, 
    required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      decoration: inputDecoration,
      onChanged: onChanged,
    );
  }
}