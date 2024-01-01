import 'package:crud/models/cart_model.dart';
import 'package:crud/models/checkout_model.dart';

class CheckoutEvent {}

class UpdateCheckout extends CheckoutEvent {
  final String? name;

  final Cart? cart;

  UpdateCheckout({this.name, this.cart});

  List<Object?> get props => [
        name,
        cart,
      ];
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;

  ConfirmCheckout({required this.checkout});
  List<Object?> get props => [checkout];
}
