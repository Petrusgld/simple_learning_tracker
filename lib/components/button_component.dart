import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final double? height;
  final double? width;
  final double size;
  final double borderRadius;
  final Color backgroundColor;
  final Color outlineColor;
  final Color? iconColor;
  final String text;
  final VoidCallback onPressed;
  final FontWeight weight;
  final IconData? icon;

  const ButtonComponent({
    super.key,
    this.height,
    this.width,
    required this.backgroundColor,
    required this.text,
    this.weight = FontWeight.w500,
    this.borderRadius = 8,
    required this.onPressed,
    this.size = 18,
    this.icon,
    this.iconColor,
    this.outlineColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColor == Colors.transparent
        ? outlineColor
        : Colors.white;

    return (icon == null)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: textColor.withOpacity(0.1),
              highlightColor: textColor.withOpacity(0.05),
              child: AnimatedContainer(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: backgroundColor == Colors.transparent
                      ? Border.all(color: outlineColor, width: 1.5)
                      : null,
                ),
                duration: Duration(milliseconds: 300),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: size,
                      color: textColor,
                      fontWeight: weight,
                    ),
                  ),
                ),
              ),
            ),
          )
        : ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(color: outlineColor),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            icon: Icon(icon, color: iconColor ?? Colors.white, size: 20),
            label: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                fontWeight: weight,
              ),
            ),
          );
  }
}
