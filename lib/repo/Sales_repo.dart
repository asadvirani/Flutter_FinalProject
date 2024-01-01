import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/Sales.dart';
import 'package:crud/models/product_model.dart';

class FirestoreSalesService {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('Sales');

  Stream<List<Sales>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // print('Firestore Data: $data');
        List<Todo> todos = List.from(data['products']).map((item) {
          return Todo(
            id: item['id'].toString(),
            title: item['title'].toString(),
            completed: item['completed'].toString(),
            price: item['price'].toString(),
            qty: item['qty'].toString(),
          );
        }).toList();

        return Sales(
          date: data['date'],
          Time: data['Time'],
          username: data['customerName'],
          todos: todos,
          subtotal: data['subtotal'],
        );
      }).toList();
    });
  }

//   Future<void> addTodo(Todo todo) {
//     return _todosCollection.add({
//       'title': todo.title,
//       'completed': todo.completed,
//       'price': todo.price,
//       'qty': todo.qty,
//     });
//   }

//   Future<void> updateTodo(Todo todo) {
//     return _todosCollection.doc(todo.id).update({
//       'title': todo.title,
//       'completed': todo.completed,
//       'price': todo.price,
//       'qty': todo.qty,
//     });
//   }

//   Future<void> deleteTodo(String todoId) {
//     return _todosCollection.doc(todoId).delete();
//   }
}
