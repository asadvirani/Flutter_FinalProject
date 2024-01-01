
import 'package:crud/models/cart_model.dart';

abstract class CartState  {
  const CartState();

  List<Object> get props => [];
}
// class CartEmpty extends CartState {}
class CartLoading extends CartState {
   @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({this.cart =  const Cart()});

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  @override
  List<Object> get props => [];
}