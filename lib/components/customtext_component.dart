import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  // final double padding;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.weight,
    this.fontFamily,
    this.size,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontFamily,
        fontWeight: weight,
      ),
    );
  }
}
