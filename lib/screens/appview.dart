import 'package:crud/bloc/auth/authentication_bloc.dart';
import 'package:crud/bloc/auth/authentication_state.dart';
import 'package:crud/bloc/sign_in/sign_in_bloc.dart';
import 'package:crud/bloc/user/my_user_bloc.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:crud/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PROJECT',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(

          primary: Colors.blueGrey,

          error: Colors.red,

        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => MyUserBloc(
                    myUserRepository:
                        context.read<AuthenticationBloc>().userRepository)
                  ..add(GetMyUser(
                      myUserId:
                          context.read<AuthenticationBloc>().state.user!.uid)),
              ),
            ],
            child: const HomeScreen(),
          );
        } else {
          return const WelcomeScreen();
        }
      }),
    );
  }
}
