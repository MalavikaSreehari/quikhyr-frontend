import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';

class QuikShortButton extends StatelessWidget {
  final String? text;
  final String? svgPath;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height;
  final double width;
  final bool isEnabled;

  const QuikShortButton({
    Key? key,
    this.text,
    this.svgPath,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor = primary,
    this.height = 60,
    this.width = 158,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled
                ? backgroundColor ?? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: isEnabled ? onPressed : null,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (svgPath != null)
                  SvgPicture.asset(
                    svgPath!,
                    color: isEnabled
                        ? foregroundColor ??
                            Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).disabledColor,
                  ),
                if (text != null) ...[
                  if (svgPath != null) QuikSpacing.hS6(),
                  Expanded(
                    child: Text(
                      text!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isEnabled
                                ? foregroundColor ??
                                    Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).disabledColor,
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
