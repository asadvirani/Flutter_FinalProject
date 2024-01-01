import 'package:crud/models/product_model.dart';

abstract class CartEvent {
  const CartEvent();

  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddProduct extends CartEvent {
  final Todo product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends CartEvent {
  final Todo product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}

class onEmptyCart extends CartEvent {
  @override
  List<Object> get props => [];
}
