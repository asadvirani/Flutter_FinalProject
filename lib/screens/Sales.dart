import 'package:crud/bloc/Sales/sales_bloc.dart';
import 'package:crud/bloc/Sales/sales_event.dart';
import 'package:crud/bloc/Sales/sales_state.dart';
import 'package:crud/screens/Cart_screen_main.dart';
import 'package:crud/screens/Dashboard/dashboard.dart';
import 'package:crud/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  @override
  void initState() {
    BlocProvider.of<Salesbloc>(context).add(LoadSales());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Salesbloc _todoBloc = BlocProvider.of<Salesbloc>(context);
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
        toolbarHeight: 200,
        backgroundColor: Colors.grey[300], // Set the app bar color

        title: Text(
          'SALES',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))],
        // backgroundColor: Colors.blueGrey[700], // Set the app bar color
      ),
      body: BlocBuilder<Salesbloc, SalesState>(
        builder: (context, state) {
          if (state is SalesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SalesLoaded) {
            final salesList = state.todos;
            // print(salesList);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: salesList.length,
                    itemBuilder: (context, index) {
                      final sales = salesList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text(
                              sales.username,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sale Amount: ${sales.subtotal}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Date: ${sales.date}"),
                                Text("Time: ${sales.Time}"),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward)),
                          ),
                        ),
                      );

                      // return Card(
                      //   color: Colors.white60,
                      //   elevation: 2,
                      //   margin:
                      //       EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      //   child: ListTile(
                      //     title: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Customer Name: ${sales.username}',
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(
                      //           'Subtotal: ${sales.subtotal}',
                      //           style: TextStyle(fontSize: 14),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(
                      //           'Items:',
                      //           style: TextStyle(
                      //               fontSize: 14, fontWeight: FontWeight.bold),
                      //         ),
                      // Displaying Todo details
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: sales.todos.length,
                      //   itemBuilder: (context, index) {
                      //     final todo = sales.todos[index];

                      // return Padding(
                      //   padding: const EdgeInsets.only(left: 16.0),
                      //   child: Column(
                      //     crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Title: ${todo.title}',
                      //         style: TextStyle(fontSize: 14),
                      //       ),
                      //       Text(
                      //         'Completed: ${todo.completed}',
                      //         style: TextStyle(fontSize: 14),
                      //       ),
                      //       Text(
                      //         'Price: ${todo.price}',
                      //         style: TextStyle(fontSize: 14),
                      //       ),
                      //       Text(
                      //         'Quantity: ${todo.qty}',
                      //         style: TextStyle(fontSize: 14),
                      //       ),
                      //     ],
                      //   ),
                      // );
                      // },
                      // ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ),
              ],
            );
          } else if (state is TodoOperationSuccess) {
            _todoBloc.add(LoadSales()); // Reload todos
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
}
