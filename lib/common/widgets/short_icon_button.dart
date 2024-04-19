import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';

class ShortIconButton extends StatelessWidget {
  final String text;
  final String? svgPath;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height;
  final double width;
  final bool isEnabled; // Added isEnabled property

  const ShortIconButton({
    Key? key,
    required this.text,
    this.svgPath,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor = primary,
    this.height = 60,
    this.width = 158,
    this.isEnabled = true, // Set default value for isEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5, // Adjust opacity based on isEnabled
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled
                ? backgroundColor ?? Theme.of(context).colorScheme.primary
                : Theme.of(context)
                    .disabledColor, // Use disabled color when not enabled
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: isEnabled
              ? onPressed
              : null, // Disable onPressed when not enabled
          child: svgPath == null
              ? Center(
                  // Center the text if only text is specified
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isEnabled
                              ? foregroundColor ??
                                  Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context)
                                  .disabledColor, // Use disabled color for text when not enabled
                        ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      svgPath!,
                      color: isEnabled
                          ? foregroundColor ??
                              Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context)
                              .disabledColor, // Use disabled color for SVG when not enabled
                    ),
                    QuikSpacing.hS6(),
                    Expanded(
                      // Wrap the Text widget with Expanded
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isEnabled
                                  ? foregroundColor ??
                                      Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context)
                                      .disabledColor, // Use disabled color for text when not enabled
                            ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
