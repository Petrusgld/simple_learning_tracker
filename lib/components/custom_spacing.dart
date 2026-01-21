import 'package:flutter/material.dart';

class CustomSpacing extends StatelessWidget {

  final double height;
  final double width;

  const CustomSpacing({
    super.key,
    this.height = 0,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
