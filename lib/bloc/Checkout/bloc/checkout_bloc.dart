import 'package:crud/bloc/Cart/cart_bloc.dart';
import 'package:crud/bloc/Cart/cart_state.dart';
import 'package:crud/bloc/Checkout/bloc/checkout_event.dart';
import 'package:crud/bloc/Checkout/bloc/checkout_state.dart';
import 'package:crud/repo/checkout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  // CheckoutBloc(this._firestoreService) : super(TodoInitial()) {
  final CartBloc _cartBloc;
  // final CheckoutBloc checkoutBloc;

  final checkout_repo _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required checkout_repo checkoutRepository,
  })  : _cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(cartBloc.state is CartLoaded
            ? Checkout_Loaded(
                products: (cartBloc.state as CartLoaded).cart.products,
                subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
                name: '',
              )
            : Checkout_Loading()) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _cartSubscription = _cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
          add(
            UpdateCheckout(cart: state.cart),
          );
        }
      },
    );
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (this.state is Checkout_Loaded) {
      final state = this.state as Checkout_Loaded;
      emit(
        Checkout_Loaded(
          name: event.name ?? state.name,
          products: event.cart?.products ?? state.products,
          subtotal: event.cart?.subtotalString ?? state.subtotal,
        ),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (this.state is Checkout_Loaded) {
      try {
        await _checkoutRepository.addTodo(event.checkout);
        print('Done');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
