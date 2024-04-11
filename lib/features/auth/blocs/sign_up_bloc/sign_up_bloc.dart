import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr/features/chat/notification_service.dart';
import 'package:quikhyr/models/client_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseUserRepo _userRepository;
  final _notificationsService = NotificationsService();
  SignUpBloc({required FirebaseUserRepo userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        ClientModel user =
            await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        await _notificationsService.requestPermission();
        await _notificationsService.getToken();
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(message: e.toString()));
      }
    });
  }
}
