import 'package:flutter/material.dart';

class RegulerTextFormField extends StatelessWidget {
  final InputDecoration inputDecoration;
  final bool obsecure;
  final Function(dynamic value) onChanged;
  final String? value;

  const RegulerTextFormField({
    super.key, 
    required this.inputDecoration, 
    required this.obsecure, 
    required this.onChanged,
    this.value
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      decoration: inputDecoration,
      onChanged: onChanged,
      initialValue: value,
    );
  }
}