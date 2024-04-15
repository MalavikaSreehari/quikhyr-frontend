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
import 'package:quikhyr/common/widgets/quik_search_bar.dart';
import 'package:quikhyr/features/booking/blocs/cubit/booking_cubit.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Q',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                        ),
                        TextSpan(
                          text: 'uik',
                          style:
                              TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                        ),
                        TextSpan(
                          text: 'Book',
                          style: TextStyle(
                              fontFamily: 'Trap',
                              fontSize: 24,
                              letterSpacing: -1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ClickableSvgIcon(
                    svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
                    onTap: () {
                      context.pushNamed(QuikRoutes.notificationName);
                      // BookingRepository().getBookingsById(
                      //     FirebaseAuth.instance.currentUser!.uid);
                    }),
                QuikSpacing.hS10(),
                ClickableSvgIcon(
                    svgAsset: QuikAssetConstants.logoutSvg,
                    onTap: () {
                      // context.read<SignInBloc>().add(const SignOutRequired());
                    }),
                QuikSpacing.hS24(),
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              if (state is BookingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookingLoaded) {
                return Column(
                  children: [
                    QuikSearchBar(
                      onChanged:
                          (String value) {}, // Default value for onChanged
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
                            text: "BOOKING ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "DETAILS",
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
                    Expanded(
                      child: BlocBuilder<BookingCubit, BookingState>(
                        builder: (context, state) {
                          if (state is BookingLoading) {
                            return CircularProgressIndicator();
                          } else if (state is BookingLoaded) {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  QuikSpacing.vS16(),
                              itemCount: state.booking.currentBookings.length,
                              itemBuilder: (context, index) {
                                final booking =
                                    state.booking.currentBookings[index];
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
                                      child: SvgPicture.asset(
                                        QuikAssetConstants.autoRepairSvg,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(booking.workerId,
                                            style: workerListNameTextStyle),
                                        QuikSpacing.vS8(),
                                        Text("Mechanic", style: chatSubTitle),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        QuikSpacing.vS8(),
                                        Text(booking.dateTime,
                                            style: timeGreenTextStyle),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClickableSvgIcon(
                                            svgAsset:
                                                QuikAssetConstants.qrCodeSvg,
                                            height: 32,
                                            width: 32,
                                            onTap: () {}),
                                        QuikSpacing.hS12(),
                                        ClickableSvgIcon(
                                            svgAsset: QuikAssetConstants
                                                .arrowRightUpSvg,
                                            height: 32,
                                            width: 32,
                                            onTap: () {}),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Text('Error loading bookings');
                          }
                        },
                      ),
                    ),
                    // QuikSpacing.vS24(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     RichText(
                    //       text: TextSpan(
                    //         text: "PAST ",
                    //         style: Theme.of(context).textTheme.titleMedium,
                    //         children: [
                    //           TextSpan(
                    //             text: "BOOKINGS",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .titleMedium
                    //                 ?.copyWith(
                    //                   color: primary,
                    //                 ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Row(
                    //       children: [
                    //         const Text(
                    //           "This Week",
                    //           style: filterDropDownMediumTextStyle,
                    //         ),
                    //         SvgPicture.asset(
                    //           QuikAssetConstants.dropDownArrowSvg,
                    //           width: 16,
                    //           height: 16,
                    //         )
                    //       ],
                    //     )
                    //   ],
                    // ),
                    // QuikSpacing.vS16(),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: state.booking.currentBookings.length,
                    //     itemBuilder: (context, index) {
                    //       final booking = state.booking.currentBookings[index];
                    //       return Container(
                    //         decoration: BoxDecoration(
                    //           color: textInputBackgroundColor,
                    //           borderRadius: BorderRadius.circular(16),
                    //         ),
                    //         child: ListTile(
                    //           contentPadding: const EdgeInsets.symmetric(
                    //               horizontal: 16, vertical: 8),
                    //           leading: Container(
                    //             height: 48,
                    //             width: 48,
                    //             padding: const EdgeInsets.all(12),
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               border: Border.all(color: labelColor),
                    //             ),
                    //             child: SvgPicture.asset(
                    //               QuikAssetConstants.electricalsSvg,
                    //               height: 24,
                    //               width: 24,
                    //             ),
                    //           ),
                    //           title: Text(booking.workerId,
                    //               style: workerListNameTextStyle),
                    //           subtitle:
                    //               Text(booking.status, style: chatSubTitleRead),
                    //           trailing: Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               ClickableSvgIcon(
                    //                   svgAsset: QuikAssetConstants.ratingSvg,
                    //                   height: 32,
                    //                   width: 32,
                    //                   onTap: () {}),
                    //               QuikSpacing.hS12(),
                    //               ClickableSvgIcon(
                    //                   svgAsset:
                    //                       QuikAssetConstants.arrowRightUpSvg,
                    //                   height: 32,
                    //                   width: 32,
                    //                   onTap: () {}),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                );
              } else {
                return const Center(child: Text('Error loading bookings'));
              }
            },
          ),
        ));
  }
}
