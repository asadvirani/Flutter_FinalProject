import 'package:crud/bloc/Product/product_bloc.dart';
import 'package:crud/bloc/Product/product_event.dart';
import 'package:crud/bloc/Product/product_state.dart';
import 'package:crud/models/product_model.dart';
import 'package:crud/screens/Cart_screen_main.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(LoadTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomAppBar(
        height: 65,
        // color: Colors.white60,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to Cart screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Cart_Screen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                // Navigate to Products screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomeView()),
                // );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 150,

        title: Text(
          'Catalog',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        backgroundColor: Colors.grey[300], // Set the app bar color
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Text("Search"),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      crossAxisCount: 2,
                    ),
                    padding: const EdgeInsets.all(25),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          // margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  todo.completed,
                                  height: 95,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                Text("Name: ${todo.title}"),
                                Text("Price: ${todo.price}"),
                                Text("Qty: ${todo.qty}"),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, todo);
                                  },
                                ),
                              ]),
                          // child: ListTile(
                          //   leading: Image.network(todo.completed),
                          //   title: Text(todo.title),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text("Price: ${todo.price}"),
                          //       Text("Qty: ${todo.qty}")
                          //     ],
                          //   ),
                          //   trailing: IconButton(
                          //     icon: const Icon(Icons.delete),
                          //     onPressed: () {
                          //       _showDeleteConfirmationDialog(context, todo);
                          //     },
                          //   ),
                          // ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is TodoOperationSuccess) {
            _todoBloc.add(LoadTodos()); // Reload todos
            return Container(); // Or display a success message
          } else if (state is TodoError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${todo.title}?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[700], // Set the button color
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[700], // Set the button color
              ),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo.id));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final _titleController = TextEditingController();
    final _priceController = TextEditingController();
    final _qtyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Product Title', _titleController),
              _buildTextField('Product Price', _priceController),
              _buildTextField('Product Quantity', _qtyController),
            ],
          ),
          actions: [
            _buildDialogButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            _buildDialogButton(
              text: 'Add',
              onPressed: () {
                final todo = Todo(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  completed: "",
                  price: _priceController.text,
                  qty: _qtyController.text,
                );
                BlocProvider.of<TodoBloc>(context).add(AddTodo(todo));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDialogButton(
      {required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          // primary: Colors.blueGrey[700], // Set the button color
          ),
      child: Text(text),
    );
  }
}
