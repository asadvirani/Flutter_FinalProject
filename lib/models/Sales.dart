import 'package:crud/models/product_model.dart';

class Sales {
  String username;
  List<Todo> todos;

  String subtotal;
  String? date;
  String? Time;

  Sales({
    required this.username,
    required this.todos,
    required this.subtotal,
        required this.date,
            required this.Time,
  });

  Sales copyWith({
    String? username,
    List<Todo>? todos,
    String? subtotal,
    String? date,
    String? time,
  }) {
    return Sales(
      username: username ?? this.username,
      todos: todos ?? this.todos,
      subtotal: subtotal ?? this.subtotal,
      date: date ?? this.date,
      Time: Time ?? this.Time,
    );
  }
}
