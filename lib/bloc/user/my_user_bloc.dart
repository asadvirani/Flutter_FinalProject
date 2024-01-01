import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:crud/models/User_model.dart';
import 'package:crud/repo/user_repo.dart';
import 'package:equatable/equatable.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
	final UserRepository _userRepository;

  MyUserBloc({
		required UserRepository myUserRepository
	}) : _userRepository = myUserRepository,
		super(const MyUserState.loading()) {
    on<GetMyUser>((event, emit) async {
      try {
				MyUser myUser = await _userRepository.getMyUser(event.myUserId);
        emit(MyUserState.success(myUser));
      } catch (e) {
			log(e.toString());
			emit(const MyUserState.failure());
      }
    });
  }
}
