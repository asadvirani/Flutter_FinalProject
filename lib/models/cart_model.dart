import 'package:crud/models/product_model.dart';

class Cart {
  final List<Todo> products;

  const Cart({this.products = const <Todo>[]});

  List<Object?> get props => [products];

  Map productQuantity(products) {
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });

    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + int.parse(current.price));

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
}
