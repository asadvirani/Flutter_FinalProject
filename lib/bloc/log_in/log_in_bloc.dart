


import 'package:crud/bloc/log_in/log_in_event.dart';
import 'package:crud/bloc/log_in/log_in_state.dart';
import 'package:crud/models/User_model.dart';
import 'package:crud/repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
	final UserRepository _userRepository;

  SignUpBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
			emit(SignUpProcess());
      try {
				MyUser user = await _userRepository.signUp(event.user, event.password);
				await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
