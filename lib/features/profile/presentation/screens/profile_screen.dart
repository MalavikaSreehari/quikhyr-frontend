import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_routes.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_app_bar.dart';
import 'package:quikhyr/common/widgets/quik_short_button.dart';

import '../../../../common/widgets/quik_small_text_with_border.dart';
import '../../../../models/worker_model.dart';

class ProfileScreen extends StatelessWidget {
  final WorkerModel worker;
  const ProfileScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuikAppBar(
        onlyHasTitle: true,
        showBackButton: true,
        showPageName: false,
        title: worker.name,
        trailingWidgets: [
          QuikSmallTextWithBorder(
            borderColor: worker.available ? quikHyrGreen : quikHyrRed,
            textColor: worker.available ? quikHyrGreen : quikHyrRed,
            text: worker.available ? "Available" : "Unavailable",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const GradientSeparator(),
            QuikSpacing.vS24(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker.name,
                      style: largeHeadingTextStyle,
                    ),
                    // QuikSpacing.vS12(),
                    // Text(
                    //   "Plumber & Mechanic",
                    //   style: subtitleMediumTextStyle,
                    // ),
                    QuikSpacing.vS16(),
                    Text(worker.locationName ?? "Location",
                        style: subtitleMediumPrimaryTextStyle)
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(worker.avatar),
                  ),
                )
              ],
            ),
            QuikSpacing.vS24(),
            Row(
              children: [
                QuikShortButton(
                  text: "Message",
                  svgPath: QuikAssetConstants.sendSvg,
                  onPressed: () {
                    context.pushNamed(QuikRoutes.chatConversationName,
                        pathParameters: {
                          'workerId': worker.id,
                        });
                  },
                )
              ],
            ),
            QuikSpacing.vS32(),
            Text(
              "ABOUT",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            QuikSpacing.vS16(),
            Text(
              "I am a highly skilled and experienced plumber and mechanic with over 10 years of experience in the field. I am proficient in all aspects of",
              style: descriptionTextStyle,
            )
          ]),
        ),
      ),
    );
  }
}
