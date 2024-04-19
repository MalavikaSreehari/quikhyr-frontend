import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_routes.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/enums/status.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_app_bar.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:quikhyr/common/widgets/status_text.dart';
import 'package:quikhyr/features/booking/blocs/cubit/booking_cubit.dart';
import 'package:quikhyr/models/booking_model.dart';

class BookingDetailScreen extends StatelessWidget {
  final Booking booking;
  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: QuikAppBar(
          title: booking.workerName,
          subtitle: booking.serviceName,
          showPageName: false,
          hasCircleBorder: true,
          circleBorderColor:
              booking.status == Status.pending ? primary : labelColor,
          leadingSvgLink: booking.serviceAvatar,
          showBackButton: true,
          trailingWidgets: [
            ClickableSvgIcon(
                svgAsset: QuikAssetConstants.qrCodeSvg,
                height: 32,
                width: 32,
                onTap: () {
                  context.pushNamed(QuikRoutes.bookingQrName, pathParameters: {
                    "qrData": booking.id.hashCode.toString()
                  });
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GradientSeparator(),
              QuikSpacing.vS12(),
              Text("OVERVIEW", style: Theme.of(context).textTheme.titleMedium),
              QuikSpacing.vS24(),
              const Text(
                "Get a complete overview of the booking you have made.",
                style: descriptionTextStyle,
              ),
              QuikSpacing.vS32(),
              RichText(
                text: TextSpan(
                  text: "Time Slot: ",
                  style: bodyLargeTextStyle,
                  children: [
                    TextSpan(
                      text: "${booking.dateTime}",
                      style: timeGreenLargeTextStyle,
                    ),
                  ],
                ),
              ),
              QuikSpacing.vS16(),
              RichText(
                text: TextSpan(
                  text: "Work Rate: ",
                  style: bodyLargeTextStyle,
                  children: [
                    TextSpan(
                      text: "${booking.ratePerUnit} /${booking.unit}",
                      style: bodyLargeBoldTextStyle,
                    ),
                  ],
                ),
              ),
              QuikSpacing.vS32(),
              StatusText(status: booking.status),
              QuikSpacing.vS32(),
              if (booking.status != Status.completed)
                const QuikListTileButtonAndText(
                  title: "Cancel Booking",
                  leadingSvgLink: QuikAssetConstants.cancelBookingSvg,
                ),
              const QuikListTileButtonAndText(
                  title: "Download booking details",
                  leadingSvgLink: QuikAssetConstants.downloadSvg)
            ],
          ),
        ));
  }
}

class QuikListTileButtonAndText extends StatelessWidget {
  final String title;
  final String leadingSvgLink;
  const QuikListTileButtonAndText({
    super.key,
    required this.title,
    required this.leadingSvgLink,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(leadingSvgLink),
      title: Text(
        title,
        style: workerListNameTextStyle,
      ),
    );
  }
}
