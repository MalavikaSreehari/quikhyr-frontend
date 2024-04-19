import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';

class QuikSearchBar extends StatefulWidget {
  final String hintText;
  final VoidCallback onMicPressed;
  final Function(String) onSearch;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const QuikSearchBar({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.onMicPressed,
    required this.onSearch,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuikSearchBar> createState() => _QuikSearchBarState();
}

class _QuikSearchBarState extends State<QuikSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(
            Icons.search,
            color: textInputIconColor,
          ),
        ),
        suffixIcon: SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
                child: VerticalDivider(color: textInputIconColor),
              ),
              QuikSpacing.hS12(),
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.searchMicSvg,
                  onTap: widget.onMicPressed),
              QuikSpacing.hS24(),
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: primary),
        ),
        filled: true,
        fillColor: _focusNode.hasFocus
            ? textInputActiveBackgroundColor
            : textInputBackgroundColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSearch,
    );
  }
}
