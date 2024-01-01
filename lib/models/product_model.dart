class Todo {
  String id;
  String title;
  String completed;
  String price;
  String qty;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.price,
    required this.qty,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? completed,
    String? price,
    String? qty,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'price': price,
      'qty': qty,
    };
  }
}
