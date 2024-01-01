// import 'package:crud/bloc/Cart/cart_bloc.dart';
// import 'package:crud/bloc/Cart/cart_event.dart';
// import 'package:crud/bloc/Checkout/bloc/checkout_bloc.dart';
// import 'package:crud/bloc/Product/product_bloc.dart';
// import 'package:crud/firebase_options.dart';
// import 'package:crud/repo/Product_repo.dart';
// import 'package:crud/repo/checkout_repo.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   AuthRepository authRepository = AuthRepository();
//   runApp(MyApp(authRepository: authRepository));
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key, required this.authRepository});
//   late final AuthRepository authRepository;
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           //BlocProvider(
//           //  create: (context) =>   AuthenticationBloc(AuthenticationRepositoryImpl())
//           //   ..add(AuthenticationStarted()),
//           // ),
//           BlocProvider<AppBloc>(
//             create: (_) => AppBloc(authRepository: authRepository),
//           ),
//           BlocProvider<LoginCubit>(
//             create: (context) {
//               return LoginCubit(authRepository);
//             },
//           ),
//           BlocProvider<SignupCubit>(
//             create: (_) => SignupCubit(authRepository),
//           ),

//           BlocProvider<TodoBloc>(
//             create: (context) => TodoBloc(FirestoreService()),
//           ),

//           BlocProvider(
//             create: (context) => CartBloc()..add(LoadCart()),
//           ),
//           BlocProvider(
//             create: (context) => CheckoutBloc(
//               cartBloc: context.read<CartBloc>(),
//               checkoutRepository: checkout_repo(),
//             ),
//           ),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//               colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
//           home: const LoginScreen(),
//         ));
//   }
// }

import 'package:crud/firebase_options.dart';
import 'package:crud/repo/auth_repo.dart';
import 'package:crud/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp(FirebaseUserRepository()));
}
