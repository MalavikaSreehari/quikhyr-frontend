import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/notification_repo.dart';
import '../../../models/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;
  NotificationCubit(this._notificationRepo) : super(NotificationInitial());
  void sendNotification(NotificationModel notification) async{
    emit(const NotificationSentLoading());
    final result = await _notificationRepo.createNotification(notification);
    result.fold(
      (error) => emit(NotificationSentError(error: error)),
      (success) => emit(const NotificationSentSuccess()),
    );
  }
}
