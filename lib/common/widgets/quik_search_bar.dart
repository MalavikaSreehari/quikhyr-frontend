import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/app_colors.dart';

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
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.mic_none_rounded,
            color: textInputIconColor,
          ),
          onPressed: widget.onMicPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: primary),
        ),
        // disabledBorder: OutlineInputBorder(
        //   borderRadius: borderRadius,
        //   borderSide: const BorderSide(color: Colors.red),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: borderRadius,
        //   borderSide: const BorderSide(color: Colors.red),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: borderRadius,
        //   borderSide: const BorderSide(color: Colors.red),
        // ),
        filled: true,
        fillColor: _focusNode.hasFocus
            ? textInputActiveBackgroundColor
            : textInputBackgroundColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSearch,
    );
  }
}
