import 'package:flutter/material.dart';

class RegulerButton extends StatelessWidget {
  final Widget childWidget;

  const RegulerButton({
    super.key, 
    required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 254, 3, 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: childWidget
    );
  }
}