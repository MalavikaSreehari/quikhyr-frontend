import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import '../../../../common/constants/quik_colors.dart';
import '../../../../models/chat_message_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isImage,
    required this.message,
  });

  final bool isMe;
  final bool isImage;
  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) => Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
              // color: isMe ? primary : Colors.grey,
              color: gridItemBackgroundColor,
              // borderRadius: isMe
              //     ? const BorderRadius.only(
              //         topRight: Radius.circular(30),
              //         bottomLeft: Radius.circular(30),
              //         topLeft: Radius.circular(30),
              //       )
              //     : const BorderRadius.only(
              //         topRight: Radius.circular(30),
              //         bottomRight: Radius.circular(30),
              //         topLeft: Radius.circular(30),
              //       ),
              borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              isImage
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(message.content),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Text(message.content, style: bodyLargeBoldTextStyle),
              const SizedBox(height: 5),
              Text(
                timeago.format(message.sentTime),
                style: chatSubTitleTime,
              ),
            ],
          ),
        ),
      );
}
