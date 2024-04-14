import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/short_icon_button.dart';
import 'package:quikhyr/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr/features/chat/notification_service.dart';
import 'package:quikhyr/models/chat_message_model.dart';

class BookingRequestBubble extends StatefulWidget {
  final bool isMe;
  final String receiverId;
  final ChatMessageModel message;
  const BookingRequestBubble({
    Key? key,
    required this.isMe,
    required this.receiverId,
    required this.message,
  }) : super(key: key);

  @override
  State<BookingRequestBubble> createState() => _BookingRequestBubbleState();
}

class _BookingRequestBubbleState extends State<BookingRequestBubble> {
  final notificationsService = NotificationsService();

  Future<void> _respondToBookingProposal(BuildContext context,
      String receiverId, String messageId, bool isAccepted) async {
    await FirebaseFirestoreService.updateBookingProposal(
        textMessageId: messageId,
        receiverId: receiverId,
        isAccepted: isAccepted);

    await notificationsService.sendNotification(
      body: "Booking Accepted By ${FirebaseAuth.instance.currentUser!.uid}",
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );

    if (context.mounted) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: widget.isMe ? primary : secondary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  'Content: ${widget.message.content}',
                  overflow: TextOverflow.ellipsis,
                  style: descriptionTextStyle,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Price per Unit: ${widget.message.pricePerUnit.toString()}',
                style: descriptionTextStyle,
              ),
              const SizedBox(height: 5.0),
              Text(
                'Unit: ${widget.message.unit.toString()}',
                style: descriptionTextStyle,
              ),
              if (!widget.isMe) ...[
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    ShortIconButton(
                        isEnabled: widget.message.hasResponded == null,
                        text: 'Accept',
                        onPressed: () {
                          _respondToBookingProposal(context, widget.receiverId,
                              widget.message.id ?? "99", true);
                          
                        }),
                    const SizedBox(width: 10.0),
                    ShortIconButton(
                        isEnabled: widget.message.hasResponded == null,
                        text: 'Reject',
                        onPressed: () {
                          _respondToBookingProposal(context, widget.receiverId,
                              widget.message.id ?? "99", false);
                        }),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.message.hasResponded == null
                      ? 'Please respond to the booking proposal'
                      : (widget.message.isAccepted ?? false
                          ? 'You have accepted the booking proposal'
                          : 'You have rejected the booking proposal'),
                  style: TextStyle(
                    color: widget.message.isAccepted ?? false
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              // if (isMe) ...[
              //   const SizedBox(height: 10.0),
              //   Text(
              //     message.isAccepted ?? false
              //         ? 'Client accepted'
              //         : 'Waiting for acceptance from client',
              //     style: TextStyle(
              //       color: message.isAccepted ?? false
              //           ? Colors.green
              //           : Colors.orange,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ],
            ],
          ),
        ),
      ],
    );
  }
}
