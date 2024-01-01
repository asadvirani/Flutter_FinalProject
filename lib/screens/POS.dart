import 'package:crud/bloc/Cart/cart_bloc.dart';
import 'package:crud/bloc/Cart/cart_event.dart';
import 'package:crud/bloc/Cart/cart_state.dart';
import 'package:crud/bloc/Product/product_bloc.dart';
import 'package:crud/bloc/Product/product_event.dart';
import 'package:crud/bloc/Product/product_state.dart';
import 'package:crud/screens/Cart_screen_main.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:crud/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class POS extends StatefulWidget {
  const POS({Key? key}) : super(key: key);

  @override
  State<POS> createState() => _POSState();
}

class _POSState extends State<POS> {
  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(LoadTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);
    final CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300], // Set the app bar color
      bottomNavigationBar: BottomAppBar(
        height: 65,
        // color: Colors.white60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // // Navigate to Cart screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Cart_Screen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                // Navigate to Products screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 150,
        title: const Text(
          'POS',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        backgroundColor: Colors.grey[300], // Set the app bar color
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart_Screen()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
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
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Text("${todo.title}"),
                                      Spacer(),
                                      Text("Price: ${todo.price}"),
                                    ],
                                  ),
                                ),
                                BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    if (state is CartLoading) {
                                      return CircularProgressIndicator();
                                    }
                                    if (state is CartLoaded) {
                                      return IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          _cartBloc.add(AddProduct(todo));
                                          _showItemAddedSnackBar(
                                              context, todo.title);
                                        },
                                      );
                                    } else {
                                      return Text("An error occurred");
                                    }
                                  },
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
            // ListView.builder(
            //   itemCount: todos.length,
            //   itemBuilder: (context, index) {
            //     final todo = todos[index];
            //     return ListTile(
            //       title: Container(
            //         padding: EdgeInsets.all(16),
            //         decoration: BoxDecoration(
            //           color: Colors.blueGrey[100], // Set the box color
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               todo.title,
            //               style: TextStyle(
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Text(
            //               'Price: ${todo.price}',
            //               style: TextStyle(fontSize: 16),
            //             ),
            //             Text(
            //               'Quantity: ${todo.qty}',
            //               style: TextStyle(fontSize: 16),
            //             ),
            //           ],
            //         ),
            //       ),
            //       trailing: BlocBuilder<CartBloc, CartState>(
            //         builder: (context, state) {
            //           if (state is CartLoading) {
            //             return CircularProgressIndicator();
            //           }
            //           if (state is CartLoaded) {
            //             return IconButton(
            //               icon: const Icon(Icons.add),
            //               onPressed: () {
            //                 _cartBloc.add(AddProduct(todo));
            //                 _showItemAddedSnackBar(context, todo.title);
            //               },
            //             );
            //           } else {
            //             return Text("An error occurred");
            //           }
            //         },
            //       ),
            //     );
            //   },
            // );
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
    );
  }

  void _showItemAddedSnackBar(BuildContext context, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
