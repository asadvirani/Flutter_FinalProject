import 'package:crud/models/checkout_model.dart';
import 'package:crud/models/product_model.dart';

abstract class CheckoutState {}

// class TodoInitial extends CheckoutState {}

class Checkout_Empty extends CheckoutState {}

class Checkout_Loading extends CheckoutState {}

class Checkout_Loaded extends CheckoutState {
  final Checkout checkout;

  // Checkout_Loaded(this.checkout);

   final String name;
  final List<Todo>? products;
  final String subtotal;


  Checkout_Loaded({
    required this.name,
    this.products,
    required this.subtotal,
  }) : checkout = Checkout(
          name: name,
          products: products,
          subtotal: subtotal,
        );

  List<Object?> get props => [name, products, subtotal];


}

class TodoOperationSuccess extends CheckoutState {
  final String message;

  TodoOperationSuccess(this.message);
}

class TodoError extends CheckoutState {
  final String errorMessage;

  TodoError(this.errorMessage);
}

