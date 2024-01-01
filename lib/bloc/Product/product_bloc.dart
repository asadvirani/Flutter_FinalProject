import 'package:crud/repo/Product_repo.dart';
import 'package:crud/bloc/Product/product_event.dart';
import 'package:crud/bloc/Product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FirestoreService _firestoreService;

  TodoBloc(this._firestoreService) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      try {
        emit(TodoLoading());
        final todos = await _firestoreService.getTodos().first;
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to load todos.'));
        print(e);
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.addTodo(event.todo);
        emit(TodoOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(TodoError('Failed to add todo.'));
        print(e);
      }
    });

    on<UpdateTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.updateTodo(event.todo);
        emit(TodoOperationSuccess('Todo updated successfully.'));
      } catch (e) {
        emit(TodoError('Failed to update todo.'));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.deleteTodo(event.todoId);
        emit(TodoOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(TodoError('Failed to delete todo.'));
      }
    });
  }
}
