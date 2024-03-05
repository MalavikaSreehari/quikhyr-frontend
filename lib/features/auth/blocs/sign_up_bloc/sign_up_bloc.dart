import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr/models/user_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
	final FirebaseUserRepo _userRepository;

  SignUpBloc({
		required FirebaseUserRepo userRepository
	}) : _userRepository = userRepository,
		super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
			emit(SignUpProcess());
			try {
        UserModel user = await _userRepository.signUp(event.user, event.password);
				await _userRepository.setUserData(user);
				emit(SignUpSuccess());
      } catch (e) {
				emit(SignUpFailure());
      }
    });
  }
}