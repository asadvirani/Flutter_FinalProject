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
          //scaffold => body
          // background: Colors.grey[300],
          // onBackground: Colors.amber,
          //icons
          primary: Colors.blueGrey,
          // onPrimary: Colors.amber,
          // secondary: Color.fromRGBO(244, 143, 177, 1),
          // onSecondary: Colors.white,
          // tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
          // outline: Color(0xFF424242)
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
