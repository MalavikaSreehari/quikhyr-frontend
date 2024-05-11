import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/models/booking_via_chat_model.dart';
import '../../../../common/constants/quik_colors.dart';
import '../../../../common/constants/quik_themes.dart';
import '../../../../common/widgets/quik_short_button.dart';
import '../../../booking/repository/booking_repository.dart';
import '../../firebase_firestore_service.dart';
import '../../notification_service.dart';
import '../../../../models/chat_message_model.dart';
import '../../../../models/location_model.dart';

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

  Future<void> _respondToBookingProposal(
      BuildContext context,
      String receiverId,
      String messageId,
      ChatMessageModel message,
      bool isAccepted) async {
    debugPrint(message.timeslot.toString());

    if (!isAccepted) {
      // Send rejection notification
      await notificationsService.sendNotification(
        body: "Booking Rejected By ${FirebaseAuth.instance.currentUser!.uid}",
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
      // Update the booking proposal status
      await FirebaseFirestoreService.updateBookingProposal(
          textMessageId: messageId,
          receiverId: receiverId,
          isAccepted: isAccepted);
      return;
    }

    final response = await BookingRepository().createBooking(
      BookingViaChatModel(
        hasRated: false,
        subserviceId:
            message.subserviceId ?? "99", // Default value for subserviceId
        location: LocationModel(latitude: 55, longitude: 55),
        clientId: message.receiverId,
        dateTime: message.timeslot ?? DateTime.now(),
        ratePerUnit: message.ratePerUnit ?? 0.0,
        status: "Pending",
        unit: message.unit ?? "-99", // Default value for unit
        workerId: message.senderId,
      ),
    );

    // Check the result of the createBooking call
    final isSuccess = response.fold((l) {
      debugPrint(l.toString());
      return false; // Return false if there's an error
    }, (r) => true); // Return true if successful

    // Only run the following methods if createBooking was successful
    if (isSuccess) {
      debugPrint("Booking created successfully");
      // await FirebaseFirestoreService.respondToBookingProposal(
      //     receiverId: widget.receiverId, isAccepted: isAccepted);

      await notificationsService.sendNotification(
        body: "Booking Accepted By ${FirebaseAuth.instance.currentUser!.uid}",
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }

      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }

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
            // color: widget.isMe ? primary : secondary,
            color: gridItemBackgroundColor,
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
                'Price per Unit: ${widget.message.ratePerUnit.toString()}',
                style: descriptionTextStyle,
              ),
              const SizedBox(height: 5.0),
              Text(
                'Unit: ${widget.message.unit.toString()}',
                style: descriptionTextStyle,
              ),
              if (!widget.isMe) ...[
                const SizedBox(height: 10.0),
                if (widget.message.hasResponded == null)
                  Row(
                    children: [
                      QuikShortButton(
                          isEnabled: widget.message.hasResponded == null,
                          text: 'Accept',
                          onPressed: () {
                            _respondToBookingProposal(
                              context,
                              widget.receiverId,
                              widget.message.id ?? "99",
                              widget.message,
                              true,
                            );
                          }),
                      const SizedBox(width: 10.0),
                      QuikShortButton(
                          foregroundColor: quikHyrRed,
                          backgroundColor: secondary,
                          text: 'Reject',
                          onPressed: () {
                            _respondToBookingProposal(
                                context,
                                widget.receiverId,
                                widget.message.id ?? "99",
                                widget.message,
                                false);
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
