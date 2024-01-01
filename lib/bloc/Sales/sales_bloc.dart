import 'package:crud/bloc/Sales/sales_event.dart';
import 'package:crud/bloc/Sales/sales_state.dart';
import 'package:crud/repo/Sales_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Salesbloc extends Bloc<SalesEvent, SalesState> {
  final FirestoreSalesService _firestoreService;

  Salesbloc(this._firestoreService) : super(SalesInitial()) {
    on<LoadSales>((event, emit) async {
      try {
        emit(SalesLoading());
        final todos = await _firestoreService.getTodos().first;
        // print(todos);
        emit(SalesLoaded(todos));
      } catch (e) {
        print(e);
        emit(TodoError('Failed to load todos.'));
      }
    });
  }
}
