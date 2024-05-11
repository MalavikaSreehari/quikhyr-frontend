import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/bloc/worker_bloc.dart';
import '../../features/notification/cubit/notification_cubit.dart';
import '../constants/quik_asset_constants.dart';
import '../constants/quik_colors.dart';
import '../constants/quik_routes.dart';
import '../constants/quik_themes.dart';
import '../utils/format_date.dart';
import '../widgets/gradient_separator.dart';
import '../widgets/quik_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const QuikAppBar(
        showBackButton: true,
        pageName: 'Notifications',
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const GradientSeparator();
                },
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 48,
                      width: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        color: onSecondary,
                        QuikAssetConstants.plumbingSvg,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    title: Text(
                        notification.type?.notificationListTileDisplayString ??
                            "Notification Category",
                        style: Theme.of(context).textTheme.headlineSmall),
                    subtitle: Text(
                        notification.description ?? "Notification Description",
                        style: chatSubTitle),
                    trailing: Text(
                      formatDate(
                          notification.timestamps?.updatedAt.toDateTime() ??
                              DateTime.now()),
                      style: chatTrailingActive,
                    ),
                    onTap: () {
                      context.pushNamed(QuikRoutes.notificationDetailName,
                          extra: notification);
                      context.read<WorkerBloc>().add(FetchWorker(
                          workerId: notification.senderId ??
                              "ERROR GETTING WORKER ID"));
                    },
                  );
                },
              ),
            );
          } else if (state is NotificationError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("No Notifications Found"));
          }
        },
      ),
    );
  }
}
