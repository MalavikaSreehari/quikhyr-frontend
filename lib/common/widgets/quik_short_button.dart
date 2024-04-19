import 'package:flutter/material.dart';

class QuikShortButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool hasIcon;
  final bool iconLeft;
  final double borderRadius;

  const QuikShortButton({super.key, 
    required this.text,
    this.backgroundColor = const Color(0xFF297AA3),
    this.foregroundColor = Colors.white,
    this.hasIcon = false,
    this.iconLeft = false,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasIcon && iconLeft) Icon(Icons.star, color: foregroundColor), // Replace with your icon
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: foregroundColor),
              textAlign: TextAlign.center,
            ),
          ),
          if (hasIcon && !iconLeft) Icon(Icons.star, color: foregroundColor), // Replace with your icon
        ],
      ),
    );
  }
}
