import 'package:crud/bloc/Cart/cart_bloc.dart';
import 'package:crud/bloc/Cart/cart_event.dart';
import 'package:crud/bloc/Checkout/bloc/checkout_bloc.dart';
import 'package:crud/bloc/Product/product_bloc.dart';
import 'package:crud/bloc/Sales/sales_bloc.dart';
import 'package:crud/bloc/auth/authentication_bloc.dart';
import 'package:crud/repo/Product_repo.dart';
import 'package:crud/repo/Sales_repo.dart';
import 'package:crud/repo/checkout_repo.dart';
import 'package:crud/repo/user_repo.dart';
import 'package:crud/screens/appview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
	final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
			providers: [
				RepositoryProvider<AuthenticationBloc>(
					create: (_) => AuthenticationBloc(
						myUserRepository: userRepository
					)
				),
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(FirestoreService()),
          ),

           BlocProvider<Salesbloc>(
            create: (context) => Salesbloc(FirestoreSalesService()),
          ),

          BlocProvider(
            create: (context) => CartBloc()..add(LoadCart()),
          ),
          
          BlocProvider(
            create: (context) => CheckoutBloc(
              cartBloc: context.read<CartBloc>(),
              checkoutRepository: checkout_repo(),
            ),)
			], 
			child: const MyAppView()
		);
  }
}