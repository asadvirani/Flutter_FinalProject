import 'dart:async';

import 'package:crud/bloc/Cart/cart_state.dart';
import 'package:crud/bloc/Cart/cart_event.dart';
import 'package:crud/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<onEmptyCart>(_onEmptyCart);
  }

  void _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<CartState> emit,
  ) {
    if (this.state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((this.state as CartLoaded).cart.products)
                ..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<CartState> emit,
  ) {
    if (this.state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((this.state as CartLoaded).cart.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }

  void _onEmptyCart(
    onEmptyCart event,
    Emitter<CartState> emit,
  ) {
    if (this.state is CartLoaded) {
      try {
        emit(CartLoaded(cart: const Cart(products: [])));
      } on Exception {
        emit(CartError());
      }
    }
  }
}

// void _onEmptyCart(
//   event,
//   emit,
// ) {
//   emit(CartLoaded(cart: const Cart(products: [])));

// }





