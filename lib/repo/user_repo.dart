import 'package:crud/models/User_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {

	Stream<User?> get user;
	
	Future<void> signIn(String email, String password);

	Future<void> logOut();

	Future<MyUser> signUp(MyUser myUser, String password);

	Future<void> resetPassword(String email);

	Future<void> setUserData(MyUser user);

	Future<MyUser> getMyUser(String myUserId);

}