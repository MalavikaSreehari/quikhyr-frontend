import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import '../../firebase_firestore_service.dart';
import '../../media_service.dart';
import 'package:quikhyr/features/chat/notification_service.dart';
import 'custom_text_form_field.dart';

class ChatTextField extends StatefulWidget {
  final String receiverId;
  const ChatTextField({super.key, required this.receiverId});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  final notificationsService = NotificationsService();

  Uint8List? file;

  @override
  void initState() {
    notificationsService.getReceiverToken(widget.receiverId);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: ChatTextFormField(
              onSend: () {
                _sendText(context);
              },
              onImageSend: () {
                _showMediaOptions();
              },
              controller: controller,
              hintText: 'Message...',
            ),
          ),
        ],
      );

  Future<void> _sendText(BuildContext context) async {
    final String text = controller.text;
    if (text.isNotEmpty) {
      controller.clear();
      await FirebaseFirestoreService.addTextMessage(
        receiverId: widget.receiverId,
        content: text,
      ).catchError(
        (error) {
          debugPrint('Error sending message: $error');
        },
      );

      await notificationsService
          .sendNotification(
        body: text,
        senderId: FirebaseAuth.instance.currentUser!.uid,
      )
          .catchError((error) {
        debugPrint('Error sending notification: $error');
      });
    }
  }

  void _showMediaOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: ClickableSvgIcon(
                svgAsset: QuikAssetConstants.gallerySvg,
                onTap: () {},
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _sendImage(MediaInputType.gallery);
              },
            ),
            // QuikShortButton(
            //     text: "Take a Photo",
            //     svgPath: QuikAssetConstants.photoCameraSvg,
            //     onPressed: () {
            //       _sendImage(MediaInputType.camera);
            //       Navigator.pop(context);
            //     }),
            // QuikShortButton(
            //     text: "Choose from Gallery",
            //     svgPath: QuikAssetConstants.gallerySvg,
            //     onPressed: () {
            //       _sendImage(MediaInputType.gallery);
            //       Navigator.pop(context);
            //     }),
            ListTile(
              leading: ClickableSvgIcon(
                svgAsset: QuikAssetConstants.photoCameraSvg,
                onTap: () {},
              ),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _sendImage(MediaInputType.camera);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendImage(MediaInputType mediaInputType) async {
    Uint8List? pickedImage;
    if (mediaInputType == MediaInputType.camera) {
      pickedImage = await MediaService.pickImageFromCamera();
    } else {
      pickedImage = await MediaService.pickImage();
    }

    setState(() => file = pickedImage);
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!,
      );
      await notificationsService.sendNotification(
        body: 'image........',
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
    }
  }
}

enum MediaInputType { camera, gallery }
