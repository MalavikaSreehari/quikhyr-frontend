import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../models/booking_model.dart';
import '../constants/quik_asset_constants.dart';
import '../constants/quik_colors.dart';
import '../constants/quik_routes.dart';
import '../constants/quik_spacings.dart';
import '../constants/quik_themes.dart';
import '../enums/status.dart';
import 'clickable_svg_icon.dart';

class QuikPastBookingListTile extends StatelessWidget {
  const QuikPastBookingListTile({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textInputBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          height: 48,
          width: 48,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primary),
          ),
          child: SvgPicture.network(
            booking.serviceAvatar,
            height: 24,
            width: 24,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking.workerName, style: workerListNameTextStyle),
            QuikSpacing.vS8(),
            Text(booking.serviceName, style: chatSubTitle),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuikSpacing.vS8(),
            if (booking.status == Status.notCompleted)
              Text(
                  '${booking.dateTime.hour}:${booking.dateTime.minute} ${booking.dateTime.hour >= 12 ? 'PM' : 'AM'} ${booking.dateTime.toString().split(" ")[0]}',
                  style: timeGreenTextStyle.copyWith(color: quikHyrRed))
            else
              Text(
                  '${booking.dateTime.hour}:${booking.dateTime.minute} ${booking.dateTime.hour >= 12 ? 'PM' : 'AM'} ${booking.dateTime.toString().split(" ")[0]}',
                  style: timeGreenTextStyle)
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (booking.hasRated == false)
              InkWell(
                child: const Icon(Icons.feedback, color: secondary),
                onTap: () {
                  context.pushNamed(QuikRoutes.feedbackName, extra: booking);
                },
              ),
            QuikSpacing.hS12(),
            ClickableSvgIcon(
                svgAsset: QuikAssetConstants.arrowRightUpSvg,
                height: 32,
                width: 32,
                onTap: () {
                  context.goNamed(QuikRoutes.bookingDetailName, extra: booking);
                }),
          ],
        ),
      ),
    );
  }
}
