import 'package:flutter/material.dart';

class SpacingComponent extends StatelessWidget {
  final double? height;
  final double? width;

  const SpacingComponent({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
