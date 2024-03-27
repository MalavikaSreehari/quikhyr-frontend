// FILE: small_text_button_with_border.dart
import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';

class QuikSmallTextWithBorder extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const QuikSmallTextWithBorder({
    Key? key,
    required this.text,
    this.borderColor = quikHyrGreen,
    this.backgroundColor = quikHyrGreenBg,
    this.textColor = quikHyrGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: 90,
      height: 28,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: Text(
          text,
          style: availabilityTextStyle,
        ),
      ),
    );
  }
}
