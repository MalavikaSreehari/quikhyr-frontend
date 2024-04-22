// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/long_icon_button.dart';
import 'package:quikhyr/common/widgets/quik_app_bar.dart';
import 'package:quikhyr/common/widgets/quik_small_text_with_border.dart';
import 'package:quikhyr/features/home/cubit/subservice_cubit.dart';
import 'package:quikhyr/features/home/cubit/workerlist_cubit.dart';
import 'package:quikhyr/features/home/models/immediate_screen_data_model.dart';
import 'package:quikhyr/features/home/presentation/components/quik_drop_down_button.dart';
import 'package:quikhyr/features/home/presentation/components/shimmer_circle_small.dart';
import 'package:quikhyr/models/service_category_model.dart';
import 'package:quikhyr/models/sub_service_category_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeDetailScreen extends StatelessWidget {
  final ServiceModel? serviceModel;
  final String? service;
  final String? subService;
  const HomeDetailScreen({
    Key? key,
    this.service,
    this.serviceModel,
    this.subService,
    // required this.serviceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubserviceModel? selectedSubservice;
    debugPrint(serviceModel?.avatar);
    debugPrint(serviceModel?.name);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: QuikAppBar(
          showBackButton: true,
          showPageName: false,
          title: serviceModel?.name ?? "NameNotFound",
          subtitle: "Service",
          leadingSvgLink: serviceModel?.avatar ??
              QuikAssetConstants.serviceNotFoundImageSvg,
          hasCircleBorder: true,
          trailingWidgets: [
            SvgPicture.asset(QuikAssetConstants.availableCircleShadesSvg,
                semanticsLabel: "Service Avatar", height: 24, width: 24),
            QuikSpacing.hS4(),
            const Text("Available", style: availabilityTextStyle),
          ],
        ),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(56),
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 12),
        //     child: AppBar(
        //       leading: GestureDetector(
        //           onTap: () {
        //             context.pop();
        //           },
        //           child:
        //               const Icon(Icons.arrow_back_ios_new, color: secondary)),
        //       // titleSpacing: 24,
        //       // automaticallyImplyLeading: false, // Remove back button
        //       backgroundColor: Colors.transparent,
        //       title: Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //             decoration: const BoxDecoration(
        //                 shape: BoxShape.circle, color: gridItemBackgroundColor),
        //             alignment: Alignment.center,
        //             height: 36,
        //             width: 36,
        //             child: SvgPicture.network(
        //               semanticsLabel: "Service Avatar",
        //               serviceModel?.avatar ??
        //                   QuikAssetConstants.serviceNotFoundImageSvg,
        //               height: 24,
        //               placeholderBuilder: (BuildContext context) =>
        //                   Shimmer.fromColors(
        //                       baseColor: gridItemBackgroundColor,
        //                       highlightColor: Colors.grey[100]!,
        //                       child: shimmerCard()),
        //             ),
        //           ),
        //           QuikSpacing.hS12(),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 serviceModel?.name ?? "NameNotFound",
        //                 style: Theme.of(context).textTheme.titleLarge,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //               QuikSpacing.vS8(),
        //               const Text("Service", style: chatSubTitle),
        //             ],
        //           )
        //         ],
        //       ),
        //       actions: [
        // SvgPicture.asset(QuikAssetConstants.availableCircleShadesSvg,
        //     semanticsLabel: "Service Avatar", height: 24, width: 24),
        // QuikSpacing.hS4(),
        // const Text("Available", style: availabilityTextStyle),
        // QuikSpacing.hS24(),
        //       ],
        //     ),
        //   ),
        // ),

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
                              serviceModel?.name.toUpperCase() ??
                                  "NAME NOT FOUND",
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
                  onPressed: () {
                    context.pushNamed(QuikRoutes.homeImmediateBookingName,
                        extra: ImmediateBookingScreenDataModel(
                            serviceAvatar: serviceModel?.avatar ??
                                QuikAssetConstants.serviceNotFoundImageSvg,
                            id: selectedSubservice?.id ?? "0",
                            serviceId: selectedSubservice?.serviceId ?? "0",
                            serviceName: serviceModel?.name ?? "All",
                            name: selectedSubservice?.name ?? "All Subservices",
                            tags: selectedSubservice?.tags ?? ["booking"]));
                  },
                  svgPath: QuikAssetConstants.rightArrowSvg,
                ),
                QuikSpacing.vS10(),
                const Text(
                  "Make use in case of urgent service requirements.",
                  style: descriptionTextStyle,
                ),
                QuikSpacing.vS24(),
                BlocBuilder<SubserviceCubit, SubserviceState>(
                  builder: (context, state) {
                    if (state is SubservicesLoading) {
                      return const QuikDropDownButtonSubservice(
                        subservices: [],
                      );
                    } else if (state is SubservicesLoaded) {
                      if (state.subservices[0] !=
                          SubserviceModel(
                              id: "0",
                              serviceId: state.subservices[1].serviceId,
                              serviceName: "All",
                              name: "All Subservices",
                              description: "All",
                              tags: const [])) {
                        state.subservices.insert(
                            0,
                            SubserviceModel(
                                id: "0",
                                serviceId: state.subservices[1].serviceId,
                                serviceName: "All",
                                name: "All Subservices",
                                description: "All",
                                tags: const []));
                      }
                      return QuikDropDownButtonSubservice(
                        //!?VALUE CALLBACK VS VALUE SETTER VS FUNCTION
                        onSubserviceSelected: (SubserviceModel subservice) {
                          selectedSubservice = subservice;
                          debugPrint(selectedSubservice?.name);
                        },
                        subservices: state.subservices,
                      );
                    } else if (state is SubservicesError) {
                      return Text(state.message);
                    } else {
                      return const Text("Unknown Error");
                    }
                  },
                ),
                QuikSpacing.vS30(),
                Row(
                  children: [
                    Text(
                      "WORKERS",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Text(
                          "Availability",
                          style: filterDropDownMediumTextStyle,
                        ),
                        SvgPicture.asset(
                          QuikAssetConstants.dropDownArrowSvg,
                          width: 16,
                          height: 16,
                        )
                      ],
                    ),
                  ],
                ),
                QuikSpacing.vS16(),
                BlocBuilder<WorkerlistCubit, WorkerlistState>(
                  builder: (context, state) {
                    if (state is WorkerlistLoading) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is WorkerlistLoaded) {
                      return Column(
                        children: state.workers
                            .map((worker) => ListTile(
                                // onTap: () {
                                //   context.pushNamed(
                                //       QuikRoutes.chatConversationName,
                                //       pathParameters: {'workerId': worker.id},);
                                // },
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(worker.avatar),
                                ),
                                title: Text(
                                  worker.name,
                                  style: workerListNameTextStyle,
                                ),
                                subtitle: Text(
                                  worker.phone,
                                  style: workerListSubtitleTextStyle,
                                ),
                                trailing: Column(
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Rs.',
                                            style: workerListUnitTextStyle,
                                          ),
                                          TextSpan(
                                            text: '200',
                                            style: workerListPriceTextStyle,
                                          ),
                                          TextSpan(
                                            text: '/hr',
                                            style: workerListUnitTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    QuikSpacing.vS10(),
                                    SizedBox(
                                      width: 135,
                                      child: Row(
                                        children: [
                                          const QuikSmallTextWithBorder(
                                            text: 'Available',
                                          ),
                                          QuikSpacing.hS8(),
                                          ClickableSvgIcon(
                                              height: 28,
                                              width: 28,
                                              svgAsset: QuikAssetConstants
                                                  .arrowRightUpSvg,
                                              onTap: () {
                                                context.pushNamed(
                                                    QuikRoutes.profileName);
                                              })
                                          // SvgPicture.asset(
                                          //   QuikAssetConstants.arrowRightUpSvg,
                                          //   width: 28,
                                          //   height: 28,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )))
                            .toList(),
                      );
                    } else if (state is WorkerlistError) {
                      return Text(state.error);
                    } else if (state is WorkerlistDropDownLoading) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is WorkerlistDropDownLoaded) {
                      return Column(
                        children: state.workers
                            .map((worker) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(worker.avatar),
                                ),
                                title: Text(
                                  worker.name,
                                  style: workerListNameTextStyle,
                                ),
                                subtitle: Text(
                                  worker.phone,
                                  style: workerListSubtitleTextStyle,
                                ),
                                trailing: Column(
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Rs.',
                                            style: workerListUnitTextStyle,
                                          ),
                                          TextSpan(
                                            text: '200',
                                            style: workerListPriceTextStyle,
                                          ),
                                          TextSpan(
                                            text: '/hr',
                                            style: workerListUnitTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    QuikSpacing.vS10(),
                                    SizedBox(
                                      width: 135,
                                      child: Row(
                                        children: [
                                          const QuikSmallTextWithBorder(
                                            text: 'Available',
                                          ),
                                          QuikSpacing.hS8(),
                                          ClickableSvgIcon(
                                              height: 28,
                                              width: 28,
                                              svgAsset: QuikAssetConstants
                                                  .arrowRightUpSvg,
                                              onTap: () {
                                                context.pushNamed(
                                                    QuikRoutes.profileName);
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                )))
                            .toList(),
                      );
                    } else if (state is WorkerlistDropDownError) {
                      return Text(state.error);
                    } else {
                      return const Text("Unknown Error");
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
