import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

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
                      //HANDLE GO TO NOTIFICATIONS
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                child: ListView(
                  children: [
                    Container(
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
                        ), // replace with your leading icon
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Pranav Madhu",
                                style: workerListNameTextStyle),
                            QuikSpacing.vS8(),
                            const Text("Mechanic", style: chatSubTitle),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuikSpacing.vS8(),
                            const Text("09:00 - 10:00 AM",
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
                                onTap: () {}),
                            QuikSpacing
                                .hS12(), // replace with your first trailing icon
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.arrowRightUpSvg,
                                height: 32,
                                width: 32,
                                onTap:
                                    () {}), // replace with your second trailing icon
                          ],
                        ),
                      ),
                    ),
                    QuikSpacing.vS8(),
                    Container(
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
                            QuikAssetConstants.electricalsSvg,
                            height: 24,
                            width: 24,
                          ),
                        ), // replace with your leading icon
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Varsha Babu",
                                style: workerListNameTextStyle),
                            QuikSpacing.vS8(),
                            const Text("Electrician", style: chatSubTitle),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuikSpacing.vS8(),
                            const Text("1:00 - 2:00 PM",
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
                                onTap: () {}),
                            QuikSpacing
                                .hS12(), // replace with your first trailing icon
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.arrowRightUpSvg,
                                height: 32,
                                width: 32,
                                onTap:
                                    () {}), // replace with your second trailing icon
                          ],
                        ),
                      ),
                    ),
                    QuikSpacing.vS8(),
                    Container(
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
                            QuikAssetConstants.treeClimbingSvg,
                            height: 24,
                            width: 24,
                          ),
                        ), // replace with your leading icon
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Nikhit Kumar",
                                style: workerListNameTextStyle),
                            QuikSpacing.vS8(),
                            const Text("Coconut Tree Climber",
                                style: chatSubTitle),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuikSpacing.vS8(),
                            const Text("4:00 - 5:30 PM",
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
                                onTap: () {}),
                            QuikSpacing
                                .hS12(), // replace with your first trailing icon
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.arrowRightUpSvg,
                                height: 32,
                                width: 32,
                                onTap:
                                    () {}), // replace with your second trailing icon
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
              Expanded(
                child: ListView(
                  children: [
                    Container(
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
                          child: SvgPicture.asset(
                            QuikAssetConstants.electricalsSvg,
                            height: 24,
                            width: 24,
                          ),
                        ), // replace with your leading icon
                        title: const Text("Pellissery John",
                            style: workerListNameTextStyle),

                        subtitle:
                            const Text("Electrician", style: chatSubTitleRead),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.ratingSvg,
                                height: 32,
                                width: 32,
                                onTap: () {}),
                            QuikSpacing
                                .hS12(), // replace with your first trailing icon
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.arrowRightUpSvg,
                                height: 32,
                                width: 32,
                                onTap:
                                    () {}), // replace with your second trailing icon
                          ],
                        ),
                      ),
                    ),
                    QuikSpacing.vS8(),
                    Container(
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
                          child: SvgPicture.asset(
                            QuikAssetConstants.autoRepairSvg,
                            height: 24,
                            width: 24,
                          ),
                        ), // replace with your leading icon
                        title: const Text("Albert Sebastian",
                            style: workerListNameTextStyle),

                        subtitle:
                            const Text("Mechanic", style: chatSubTitleRead),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.ratingSvg,
                                height: 32,
                                width: 32,
                                onTap: () {}),
                            QuikSpacing
                                .hS12(), // replace with your first trailing icon
                            ClickableSvgIcon(
                                svgAsset: QuikAssetConstants.arrowRightUpSvg,
                                height: 32,
                                width: 32,
                                onTap:
                                    () {}), // replace with your second trailing icon
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
