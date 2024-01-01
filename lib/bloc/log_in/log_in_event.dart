
import 'package:crud/models/User_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent{
	final MyUser user;
	final String password;

	const SignUpRequired(this.user, this.password);
}
