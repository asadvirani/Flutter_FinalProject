import 'package:crud/bloc/Cart/cart_bloc.dart';
import 'package:crud/bloc/Cart/cart_event.dart';
import 'package:crud/bloc/Cart/cart_state.dart';
import 'package:crud/bloc/Checkout/bloc/checkout_bloc.dart';
import 'package:crud/bloc/Checkout/bloc/checkout_event.dart';
import 'package:crud/bloc/Checkout/bloc/checkout_state.dart';
import 'package:crud/order_summary.dart';
import 'package:crud/screens/Cart_screen_main.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:crud/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Set the app bar color
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
                // Navigate to Home screen
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 150,
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        backgroundColor: Colors.grey[300], // Set the app bar color
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is Checkout_Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Checkout_Empty) {
            return const Center(child: Text("EMPTY"));
          }

          if (state is Checkout_Loaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: MediaQuery.of(context)
                      .size
                      .height, // Set a finite height, adjust as needed

                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Set mainAxisSize to MainAxisSize.min

                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Customer Information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Name",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextField(
                        controller: nameCtrl,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Contact #",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextField(
                          // controller: nameCtrl,
                          ),
                      const SizedBox(height: 16),
                      const Text(
                        "Order Summary",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 115,
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is CartLoaded) {
                              final todos = state.cart.products;
                              if (todos.isEmpty) {
                                return const Center(child: Text("Empty"));
                              }

                              return ListView.builder(
                                // shrinkWrap: true,
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

                                  return Container(
                                    // height: ,
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
                                      trailing: Text(
                                        '$qty',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      // Spacer(),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 16),
                      Container(
                          padding: EdgeInsets.zero,
                          child: const OrderSummary()),
                      const SizedBox(height: 10),
                      BlocBuilder<CheckoutBloc, CheckoutState>(
                        builder: (context, state) {
                          if (state is Checkout_Loading) {
                            return const CircularProgressIndicator();
                          }

                          if (state is Checkout_Loaded) {
                            return GestureDetector(
                              onTap: () {
                                state.checkout.name = nameCtrl.text;
                                state.checkout.subtotal = state.subtotal;
                                // state.checkout.date =
                                context.read<CheckoutBloc>().add(
                                    ConfirmCheckout(checkout: state.checkout));
                                context.read<CartBloc>().add(LoadCart());

                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.all(25),
                                child: Center(
                                  child: Text(
                                    "Confirm Order",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const Text("Error");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
