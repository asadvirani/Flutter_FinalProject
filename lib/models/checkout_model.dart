import 'package:crud/models/product_model.dart';
import 'package:intl/intl.dart';

class Checkout {
  String name;
  List<Todo>? products;
  String? date;
  String? time;
  String subtotal;

  Checkout({
    required this.name,
    required this.products,
    required this.subtotal,
    this.date,
    this.time,
  });

  Map<String, Object> toDocument() {
    return {
      'customerName': name,
      'date': DateFormat.yMMMMd().format(DateTime.now().toLocal()),
      'Time': DateTime.now().toLocal().toString().split(' ')[1].substring(0, 5),
      'products': products!
          .map((product) => {
                'title': product.title,
                'id': product.id,
                'completed': "",
                'price': product.price,
                'qty': "1",
              })
          .toList(),
      'subtotal': subtotal,
    };
  }

  List<Object?> get props => [
        name,
        products,
        subtotal,
      ];
}
