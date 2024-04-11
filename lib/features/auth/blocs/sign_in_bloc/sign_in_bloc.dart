import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr/features/chat/notification_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
	final FirebaseUserRepo _userRepository;
	  final _notificationsService = NotificationsService();
  SignInBloc({
		required FirebaseUserRepo userRepository
	}) : _userRepository = userRepository,
		super(SignInInitial()) {
		on<SignInRequired>((event, emit) async {
			emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        await _notificationsService.requestPermission();
        await _notificationsService.getToken();
				emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
				emit(SignInFailure(message: e.code));
			} catch (e) {
				emit(const SignInFailure());
      }
    });
  
		on<SignOutRequired>((event, emit) async {
			await _userRepository.logOut();
    });
  }
}