import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_routes.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/quik_app_bar.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:quikhyr/features/booking/blocs/cubit/booking_cubit.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const QuikAppBar(
          showBackButton: false,
          showPageName: true,
          pageName: 'Book',
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                QuikSearchBar(
                  onChanged: (String value) {}, // Default value for onChanged
                  hintText: "Search for bookings...",
                  onMicPressed: () {},
                  onSearch: (String onSearch) {},
                  controller: TextEditingController(),
                ),
                QuikSpacing.vS36(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "CURRENT ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "BOOKINGS",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Arrival Time",
                          style: filterDropDownMediumTextStyle,
                        ),
                        SvgPicture.asset(
                          QuikAssetConstants.dropDownArrowSvg,
                          width: 16,
                          height: 16,
                        )
                      ],
                    )
                  ],
                ),
                QuikSpacing.vS16(),
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    if (state is BookingLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is BookingLoaded &&
                        state.booking.currentBookings.isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            QuikSpacing.vS16(),
                        itemCount: state.booking.currentBookings.length,
                        itemBuilder: (context, index) {
                          final booking = state.booking.currentBookings[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: gridItemBackgroundColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
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
                                  Text(booking.workerName,
                                      style: workerListNameTextStyle),
                                  QuikSpacing.vS8(),
                                  Text(booking.serviceName,
                                      style: chatSubTitle),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  QuikSpacing.vS8(),
                                  Text(
                                      '${booking.dateTime.hour}:${booking.dateTime.minute} ${booking.dateTime.hour >= 12 ? 'PM' : 'AM'} ${booking.dateTime.toString().split(" ")[0]}',
                                      style: timeGreenTextStyle),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClickableSvgIcon(
                                      svgAsset: QuikAssetConstants.qrCodeSvg,
                                      height: 32,
                                      width: 32,
                                      onTap: () {
                                        context.pushNamed(
                                            QuikRoutes.bookingQrName,
                                            pathParameters: {
                                              "qrData":
                                                  booking.id.hashCode.toString()
                                            });
                                      }),
                                  QuikSpacing.hS12(),
                                  ClickableSvgIcon(
                                      svgAsset:
                                          QuikAssetConstants.arrowRightUpSvg,
                                      height: 32,
                                      width: 32,
                                      onTap: () {
                                        context.goNamed(
                                            QuikRoutes.bookingDetailName,
                                            extra: booking);
                                      }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is BookingLoaded &&
                        state.booking.currentBookings.isEmpty) {
                      return const Center(
                        child: Text(
                          'No current bookings',
                          style: bodyLargeBoldTextStyle,
                        ),
                      );
                    } else {
                      return const Text('Error loading bookings');
                    }
                  },
                ),
                QuikSpacing.vS24(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "PAST ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "BOOKINGS",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "This Week",
                          style: filterDropDownMediumTextStyle,
                        ),
                        SvgPicture.asset(
                          QuikAssetConstants.dropDownArrowSvg,
                          width: 16,
                          height: 16,
                        )
                      ],
                    )
                  ],
                ),
                QuikSpacing.vS16(),
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    if (state is BookingLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is BookingLoaded &&
                        state.booking.pastBookings.isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            QuikSpacing.vS16(),
                        itemCount: state.booking.pastBookings.length,
                        itemBuilder: (context, index) {
                          final booking = state.booking.pastBookings[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: textInputBackgroundColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              leading: Container(
                                height: 48,
                                width: 48,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: labelColor),
                                ),
                                child: SvgPicture.network(
                                  booking.serviceAvatar,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              title: Text("worker50",
                                  style: workerListNameTextStyle),
                              subtitle: Text(booking.serviceName,
                                  style: chatSubTitleRead),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClickableSvgIcon(
                                      svgAsset: QuikAssetConstants.ratingSvg,
                                      height: 32,
                                      width: 32,
                                      onTap: () {}),
                                  QuikSpacing.hS12(),
                                  ClickableSvgIcon(
                                      svgAsset:
                                          QuikAssetConstants.arrowRightUpSvg,
                                      height: 32,
                                      width: 32,
                                      onTap: () {
                                        context.goNamed(
                                            QuikRoutes.bookingDetailName, extra: booking);
                                      }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is BookingLoaded &&
                        state.booking.pastBookings.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'No past bookings',
                            style: bodyLargeBoldTextStyle,
                          ),
                        ),
                      );
                    } else {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'Error loading bookings',
                            style: bodyLargeBoldTextStyle,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            )));
  }
}
