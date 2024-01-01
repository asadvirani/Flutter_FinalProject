import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/checkout_model.dart';

class checkout_repo {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('Sales');

  // Stream<List<Todo>> getTodos() {
  //   return _todosCollection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       return Todo(
  //         id: doc.id,
  //         title: data['title'],
  //         completed: data['completed'],
  //         price: data['price'],
  //         qty: data['qty'],
  //       );
  //     }).toList();
  //   });
  // }

  Future<void> addTodo(Checkout todo) {
    return _todosCollection.add(todo.toDocument());
  }
}
