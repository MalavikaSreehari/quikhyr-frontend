import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/notification/models/work_rejection_back_to_worker.dart';
import 'package:quikhyr/models/create_work_alert_model.dart';
import '../repository/notification_repo.dart';
import '../../../models/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;
  NotificationCubit(this._notificationRepo) : super(NotificationInitial());
  void sendWorkAlertNotification(CreateWorkAlertModel notification) async {
    emit(const NotificationSentLoading());
    final result = await _notificationRepo.createNotification(notification);
    result.fold(
      (error) => emit(NotificationSentError(error: error)),
      (success) => emit(const NotificationSentSuccess()),
    );
  }

  void sendWorkRejectionNotification(WorkRejectionBackToWorkerModel notification) async {
    emit(const NotificationSentLoading());
    final result = await _notificationRepo.createWorkRejection(notification);
    result.fold(
      (error) => emit(NotificationSentError(error: error)),
      (success) => emit(const NotificationSentSuccess()),
    );
  }

  // void sendWorkConfirmationNotification(NotificationModel notification) async {
  //   emit(const NotificationSentLoading());
  //   final result = await _notificationRepo.createWorkConfirmation(notification);
  //   result.fold(
  //     (error) => emit(NotificationSentError(error: error)),
  //     (success) => emit(const NotificationSentSuccess()),
  //   );
  // }



    void getNotifications() async {
    emit(const NotificationLoading());
    final result = await _notificationRepo.getNotifications();
    result.fold(
      (error) => emit(NotificationError(error: error)),
      (notifications) => emit(NotificationLoaded(notifications: notifications)),
    );
  }
}
