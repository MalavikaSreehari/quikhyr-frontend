// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/common/constants/quik_spacings.dart';
import 'package:quikhyr/common/constants/quik_themes.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/long_icon_button.dart';
import 'package:quikhyr/features/home/presentation/components/shimmer_circle_small.dart';
import 'package:quikhyr/models/service_category_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeDetailScreen extends StatelessWidget {
  final ServiceModel? serviceModel;
  final String service;
  final String? subService;
  const HomeDetailScreen({
    Key? key,
    required this.service,
    this.serviceModel,
    this.subService,
    // required this.serviceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(serviceModel?.avatar);
    debugPrint(serviceModel?.name);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child:
                      const Icon(Icons.arrow_back_ios_new, color: secondary)),
              // titleSpacing: 24,
              // automaticallyImplyLeading: false, // Remove back button
              backgroundColor: Colors.transparent,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: gridItemBackgroundColor),
                    alignment: Alignment.center,
                    height: 36,
                    width: 36,
                    child: SvgPicture.network(
                      semanticsLabel: "Service Avatar",
                      serviceModel?.avatar ??
                          QuikAssetConstants.serviceNotFoundImageSvg,
                      height: 24,
                      placeholderBuilder: (BuildContext context) =>
                          Shimmer.fromColors(
                              baseColor: gridItemBackgroundColor,
                              highlightColor: Colors.grey[100]!,
                              child: shimmerCard()),
                    ),
                  ),
                  QuikSpacing.hS12(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(serviceModel?.name ?? service,
                          style: Theme.of(context).textTheme.titleLarge),
                      QuikSpacing.vS8(),
                      const Text("Service", style: chatSubTitle),
                    ],
                  )
                ],
              ),
              actions: [
                SvgPicture.asset(QuikAssetConstants.availableCircleShadesSvg,
                    semanticsLabel: "Service Avatar", height: 24, width: 24),
                QuikSpacing.hS4(),
                const Text("Available", style: availabilityTextStyle),
                QuikSpacing.hS24(),
              ],
            ),
          ),
        ),

        // body: Center(child: Text(serviceModel.title)));
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GradientSeparator(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // if (serviceModel?.image != null)
                      Image.network(
                        serviceModel?.image ??
                            QuikAssetConstants.serviceNotFoundImagePng,
                        height: 104,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Shimmer.fromColors(
                              baseColor: gridItemBackgroundColor,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 104,
                                width: double.infinity,
                                color: gridItemBackgroundColor,
                              ));
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Shimmer.fromColors(
                              baseColor: gridItemBackgroundColor,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 104,
                                width: double.infinity,
                                color: gridItemBackgroundColor,
                              ));
                        },
                      ),
                      if (serviceModel == null)
                        Container(
                          height: 104,
                          width: double.infinity,
                          color: gridItemBackgroundColor,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Came from Unimplemented Path :|"),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8)
                              ])),
                        ),
                      ),
                      Positioned(
                          bottom: 16,
                          right: 32,
                          child: Text(
                              serviceModel?.name.toUpperCase() ?? service,
                              style: serviceImageOverlayTextStyle)),
                    ],
                  ),
                ),
                QuikSpacing.vS24(),
                Text(
                  "OVERVIEW",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                QuikSpacing.vS16(),
                Text(
                  serviceModel?.description ?? "No description available",
                  style: descriptionTextStyle,
                ),
                QuikSpacing.vS30(),
                LongIconButton(
                  text: "Immediate Booking",
                  onPressed: () {},
                  svgPath: QuikAssetConstants.rightArrowSvg,
                ),
                QuikSpacing.vS10(),
                const Text(
                  "Make use in case of urgent service requirements.",
                  style: descriptionTextStyle,
                )
              ],
            ),
          ),
        ));
  }
}
