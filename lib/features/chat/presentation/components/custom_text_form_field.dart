import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';

import '../../../../common/constants/quik_colors.dart';
import '../../../../common/constants/quik_themes.dart';

class ChatTextFormField extends StatefulWidget {
  const ChatTextFormField({
    Key? key,
    required this.controller,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.obscureText,
    this.onChanged,
    this.onSend,
    this.onImageSend,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSend;
  final VoidCallback? onImageSend;

  @override
  ChatTextFormFieldState createState() => ChatTextFormFieldState();
}

class ChatTextFormFieldState extends State<ChatTextFormField> {
  bool _isSendIconVisible = false;
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
    return TextFormField(
      focusNode: _focusNode,
      style: messageTextFieldHintTextStyle,
      showCursor: true,
      cursorColor: secondary,
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            _isSendIconVisible = true;
          });
        } else {
          setState(() {
            _isSendIconVisible = false;
          });
        }
      },
      //     suffixIcon: Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      // children: [
      //   const SizedBox(width: 5),
      // SvgPicture.asset(
      //   QuikAssetConstants.photoCameraSvg,
      //   color: placeHolderText,
      //   height: 32,
      //   width: 32,
      // ),
      //     QuikSpacing.hS24(),
      //     // CircleAvatar(
      //     //   backgroundColor: primary,
      //     //   radius: 20,
      //     //   child: IconButton(
      //     //       icon: const Icon(Icons.send, color: Colors.white),
      //     //       onPressed: () {
      //     //         // _sendText(context);
      //     //       }),
      //     // ),
      //   ],
      // ),
      decoration: InputDecoration(
        // focusColor: Colors.white,
        // hoverColor: Colors.white,
        fillColor: _focusNode.hasFocus
            ? textInputActiveBackgroundColor
            : textInputBackgroundColor,

        filled: true,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: messageTextFieldHintTextStyle,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: IconButton(
          // icon: Icon(_isSendIconVisible ? Icons.send : Icons.camera_alt),

          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 1,
                height: 24,
                child: VerticalDivider(color: textInputIconColor),
              ),
              QuikSpacing.hS12(),
              ClickableSvgIcon(
                  key: const ValueKey<int>(2),
                  color: placeHolderText,
                  svgAsset: QuikAssetConstants.photoCameraSvg,
                  onTap: widget.onImageSend ?? () {}),
              QuikSpacing.hS12(),
              ClickableSvgIcon(
                color: placeHolderText,
                svgAsset: QuikAssetConstants.sendSvg,
                onTap: widget.onSend ?? () {},
              ),
              QuikSpacing.hS6(),
            ],
          ),
          onPressed: () {
            setState(() {
              _isSendIconVisible = !_isSendIconVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary),
        ),
      ),
    );
  }
}
