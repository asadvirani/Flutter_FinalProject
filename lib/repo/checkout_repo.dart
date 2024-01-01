import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/checkout_model.dart';

class checkout_repo {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('Sales');



  Future<void> addTodo(Checkout todo) {
    return _todosCollection.add(todo.toDocument());
  }
}
