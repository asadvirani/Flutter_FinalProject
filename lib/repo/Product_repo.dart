import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/product_model.dart';

class FirestoreService {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Todo(
          id: doc.id,
          title: data['title'],
          completed: data['completed'],
          price: data['price'],
          qty: data['qty'],
        );
      }).toList();
    });
  }

  Future<void> addTodo(Todo todo) {
    return _todosCollection.add({
      'title': todo.title,
      'completed': todo.completed,
      'price': todo.price,
      'qty': todo.qty,
    });
  }

  Future<void> updateTodo(Todo todo) {
    return _todosCollection.doc(todo.id).update({
      'title': todo.title,
      'completed': todo.completed,
      'price': todo.price,
      'qty': todo.qty,
    });
  }

  Future<void> deleteTodo(String todoId) {
    return _todosCollection.doc(todoId).delete();
  }
}
