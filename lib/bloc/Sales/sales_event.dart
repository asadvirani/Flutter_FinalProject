import 'package:crud/models/Sales.dart';

abstract class SalesEvent {}

class LoadSales extends SalesEvent {}

class AddSales extends SalesEvent {
  final Sales todo;

  AddSales(this.todo);
}

class UpdateSales extends SalesEvent {
  final Sales todo;

  UpdateSales(this.todo);
}

class DeleteSales extends SalesEvent {
  final String todoId;

  DeleteSales(this.todoId);
}