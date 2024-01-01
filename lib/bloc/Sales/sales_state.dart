import 'package:crud/models/Sales.dart';

abstract class SalesState {}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final List<Sales> todos;

  SalesLoaded(this.todos);
}

class TodoOperationSuccess extends SalesState {
  final String message;

  TodoOperationSuccess(this.message);
}

class TodoError extends SalesState {
  final String errorMessage;

  TodoError(this.errorMessage);
}
