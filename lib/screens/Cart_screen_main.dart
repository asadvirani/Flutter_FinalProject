import 'package:crud/bloc/Cart/cart_state.dart';
import 'package:crud/bloc/Cart/cart_bloc.dart';
import 'package:crud/bloc/Cart/cart_event.dart';
import 'package:crud/order_summary.dart';
import 'package:crud/screens/checkout_screen.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:crud/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // // Navigate to Cart screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Cart_Screen()),
                // );
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
          'CART',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        backgroundColor: Colors.grey[300], // Set the app bar color
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Checkout()),
              );
            },
            icon: const Icon(Icons.shopping_cart_checkout),
          )
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final todos = state.cart.products;
            if (todos.isEmpty) {
              return const Center(child: Text("Empty"));
            }

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cart
                      .productQuantity(state.cart.products)
                      .keys
                      .length,
                  itemBuilder: (context, index) {
                    final todo = state.cart
                        .productQuantity(state.cart.products)
                        .keys
                        .elementAt(index);
                    final qty = state.cart
                        .productQuantity(state.cart.products)
                        .values
                        .elementAt(index);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Image.network(
                            todo.completed,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(todo.title),
                          subtitle: Text("Price: ${todo.price}"),
                          trailing: Expanded(
                            child: Container(
                              width: 110,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _cartBloc.add(RemoveProduct(todo));
                                    },
                                    icon: const Icon(Icons.remove_circle),
                                  ),
                                  Text(
                                    '$qty',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _cartBloc.add(AddProduct(todo));
                                    },
                                    icon: const Icon(Icons.add_circle),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Spacer(),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 16),
                const OrderSummary(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Checkout()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(25),
                      child: Center(
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
