import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CTextField({super.key, required this.controller, this.hintText = ''});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}