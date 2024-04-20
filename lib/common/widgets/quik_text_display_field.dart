import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';

class QuikTextDisplayField extends StatelessWidget {
  final String data;
  final Color backgroundColor;

  const QuikTextDisplayField({
    Key? key,
    required this.data,
    this.backgroundColor = textInputBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data,
        style: const TextStyle(
          color: Color.fromRGBO(233, 234, 236, 0.50),
          fontFamily: 'Trap',
          fontSize: 13,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
