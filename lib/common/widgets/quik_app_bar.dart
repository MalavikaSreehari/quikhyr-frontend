import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';

class QuikAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showPageName;
  final String? pageName;
  final Color? circleBorderColor;
  final bool? hasCircleBorder;
  final String? leadingSvgLink;
  final String? title;
  final String? subtitle;
  final List<Widget>? trailingWidgets;
  const QuikAppBar({
    this.hasCircleBorder = false,
    this.circleBorderColor,
    this.showPageName = true,
    this.showBackButton = false,
    super.key,
    this.trailingWidgets,
    this.pageName,
    this.leadingSvgLink,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AppBar(
              titleSpacing: 24,
              automaticallyImplyLeading: false, // Remove back button
              leading: showBackButton
                  ? Row(
                      children: [
                        QuikSpacing.hS12(),
                        ClickableSvgIcon(
                          svgAsset: QuikAssetConstants.backArrowSvg,
                          size: 32,
                          onTap: () {
                            context.pop();
                          },
                        ),
                        QuikSpacing.hS12(),
                      ],
                    )
                  : null,
              backgroundColor: Colors.transparent,
              title: showPageName
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Q',
                                style: TextStyle(
                                    fontFamily: 'Moonhouse', fontSize: 32),
                              ),
                              const TextSpan(
                                text: 'uik',
                                style: TextStyle(
                                    fontFamily: 'Moonhouse', fontSize: 24),
                              ),
                              TextSpan(
                                text: pageName ?? "Page",
                                style: const TextStyle(
                                    fontFamily: 'Trap',
                                    fontSize: 24,
                                    letterSpacing: -1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: circleBorderColor ?? primary),
                          ),
                          child: SvgPicture.network(
                            leadingSvgLink ??
                                QuikAssetConstants.serviceNotFoundImageSvg,
                            height: 32,
                            width: 32,
                          ),
                        ),
                        QuikSpacing.hS12(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? "Worker Name",
                              style: workerListNameTextStyle,
                            ),
                            QuikSpacing.vS8(),
                            Text(
                              subtitle ?? "Sub Service Name",
                              style: chatSubTitle,
                            ),
                          ],
                        )
                      ],
                    ),
              actions: trailingWidgets?..add(QuikSpacing.hS24())),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
