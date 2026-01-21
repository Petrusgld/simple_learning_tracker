// lib/components/CButton.dart

import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool isFullWidth; // Tambahkan ini

  const CButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.isFullWidth = false, // Default false
  });

  @override
  Widget build(BuildContext context) {
    // Logika Full Width
    return SizedBox(
      width: isFullWidth ? double.infinity : null, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}