import 'package:flutter/material.dart';

class QuikSearchBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
        shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
        hintText: hintText,
        leading: const Padding(
            padding: EdgeInsets.only(left: 12), child: Icon(Icons.search)),
        trailing: [
          const SizedBox(),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: onMicPressed,
          ),
        ],
        onChanged: onChanged,
        onSubmitted: onSearch,
        );
  }
}
