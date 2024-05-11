import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:quikhyr/common/utils/format_date.dart';
import 'package:quikhyr/features/notification/models/work_confirmation_back_to_worker.dart';
import 'package:quikhyr/features/notification/models/work_rejection_back_to_worker.dart';

import '../../../models/notification_model.dart';
import '../../features/notification/cubit/notification_cubit.dart';
import '../../models/location_model.dart';
import '../bloc/worker_bloc.dart';
import '../constants/quik_asset_constants.dart';
import '../constants/quik_colors.dart';
import '../constants/quik_routes.dart';
import '../constants/quik_spacings.dart';
import '../constants/quik_themes.dart';
import '../widgets/clickable_svg_icon.dart';
import '../widgets/gradient_separator.dart';
import '../widgets/quik_app_bar.dart';
import '../widgets/quik_short_button.dart';
import '../widgets/quik_small_text_with_border.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetailScreen({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: QuikAppBar(
          onlyHasTitle: true,
          showBackButton: true,
          showPageName: false,
          title: notification.type?.notificationListTileDisplayString ??
              "Notification Category",
        ),
        body: BlocListener<NotificationCubit, NotificationState>(
            listener: (context, state) {
              if (state is NotificationSentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Notification sent successfully"),
                  ),
                );
              }
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GradientSeparator(),
                    QuikSpacing.vS24(),
                    Text("OVERVIEW",
                        style: Theme.of(context).textTheme.headlineSmall),
                    QuikSpacing.vS24(),
                    Text(
                      notification.description ?? "Notification Description",
                    ),
                    QuikSpacing.vS32(),
                    // TextSpan(
                    //       text: DateFormat('hh:mm a').format(booking.dateTime),
                    //       style: bodyLargeBoldTextStyle.copyWith(
                    //           color: quikHyrGreen),
                    //     )
                    RichText(
                      text: TextSpan(
                        text: "Date & Time: ",
                        style: bodyLargeTextStyle,
                        children: [
                          TextSpan(
                            text:
                                '${DateFormat('hh:mm a').format(notification.dateTime ?? DateTime.now())} | ${formatDate(notification.dateTime ?? DateTime.now())}',
                            style: bodyLargeBoldTextStyle.copyWith(
                                color: quikHyrGreen),
                          )
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
                            text:
                                '${notification.ratePerUnit?.toString()} /${notification.unit}',
                            style: bodyLargeBoldTextStyle,
                          ),
                        ],
                      ),
                    ),
                    QuikSpacing.vS32(),
                    const GradientSeparator(),
                    BlocBuilder<WorkerBloc, WorkerState>(
                      builder: (context, state) {
                        if (state is WorkerLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is WorkerLoaded) {
                          return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    NetworkImage(state.worker.avatar),
                              ),
                              title: Text(
                                state.worker.name,
                                style: workerListNameTextStyle,
                              ),
                              subtitle: Text(
                                state.worker.phone,
                                style: workerListSubtitleTextStyle,
                              ),
                              trailing: ClickableSvgIcon(
                                  height: 36,
                                  width: 36,
                                  svgAsset: QuikAssetConstants.arrowRightUpSvg,
                                  onTap: () {
                                    context.pushNamed(QuikRoutes.profileName,
                                        extra: state.worker);
                                  }));
                        } else if (state is WorkerError) {
                          return const Center(
                              child: Text("No Messages Found"));
                        } else {
                          return const Center(child: Text("No messages found"));
                        }
                      },
                    ),
                    const GradientSeparator(),
                    Text(
                        notification.type?.notificationListTileDisplayString
                                .toUpperCase() ??
                            "Notification Category",
                        style: Theme.of(context).textTheme.headlineSmall),
                    QuikSpacing.vS24(),
                    Text(
                      notification.description ?? "Notification Description",
                      style: descriptionTextStyle,
                    ),
                    QuikSpacing.vS32(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        QuikShortButton(
                          paddingHorizontal: 50,
                          paddingVertical: 20,
                          backgroundColor: secondary,
                          foregroundColor: onSecondary,
                          text: "Reject",
                          onPressed: () {
                            final rejectionNotification = WorkRejectionBackToWorkerModel(
                              receiverIds: [notification.senderId ?? "RECEIVER/WORKER ID NOT FOUND"],
                              senderId: FirebaseAuth.instance.currentUser?.uid ?? "SENDER/CLIENT ID NOT FOUND",

                              workApprovalRequestId: notification.workApprovalRequestId ?? "WORK APPROVAL REQUEST ID NOT FOUND",
                              workAlertId: notification.workAlertId ?? "WORK ALERT ID NOT FOUND",
                            );
                            context
                                .read<NotificationCubit>()
                                .sendWorkRejectionNotification(rejectionNotification);
                          },
                        ),
                        QuikShortButton(
                          paddingHorizontal: 50,
                          paddingVertical: 20,
                          text: "Accept",
                          onPressed: () {
                            final confirmationNotification = WorkConfirmationBackToWorkerModel(
                              ratePerUnit: notification.ratePerUnit ?? 0,
                              unit: notification.unit ?? "UNIT NOT FOUND",
                              subserviceId: notification.subserviceId ?? "SUBSERVICE ID NOT FOUND",
                              location: notification.location ?? LocationModel(latitude: 65, longitude: 20),
                              locationName: notification.locationName ?? "LOCATION NAME NOT FOUND",
                              description: notification.description ?? "DESCRIPTION NOT FOUND",
                              dateTime: notification.dateTime ?? DateTime.now(),
                              receiverIds: [notification.senderId ?? "RECEIVER/WORKER ID NOT FOUND"],
                              senderId: FirebaseAuth.instance.currentUser?.uid ?? "SENDER/CLIENT ID NOT FOUND",

                              workApprovalRequestId: notification.workApprovalRequestId ?? "WORK APPROVAL REQUEST ID NOT FOUND",
                              workAlertId: notification.workAlertId ?? "WORK ALERT ID NOT FOUND",
                            );
                            context
                                .read<NotificationCubit>()
                                .sendWorkConfirmationNotification(confirmationNotification);
                          },
                        ),
                      ],
                    ),
                    QuikSpacing.vS12(),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Accept or reject the work approval request",
                        style: descriptionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
