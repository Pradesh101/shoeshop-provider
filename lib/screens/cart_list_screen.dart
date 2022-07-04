import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project2/models/product_model.dart';

import '../provider/product_provider.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    var cartItems = context.watch<ProductProvider>().cartList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty!!!'),
            )
          : GridView.builder(
              itemCount: cartItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1 / 1.6),
              itemBuilder: (BuildContext context, int index) {
                final Product cartProduct = cartItems[index];
                //print(products.length);
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          //margin: const EdgeInsets.only(top: 10),
                          //color: Colors.blueAccent,
                          height: 150,
                          width: double.infinity,
                          child: Image.file(
                            cartItems[index].productImgPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${cartItems[index].productName}',
                                textAlign: TextAlign.left,
                              ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              Text(
                                'Price: \$${cartItems[index].productPrice.toString()}',
                                textAlign: TextAlign.left,
                              ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              Text(
                                'Color: ${cartItems[index].productColor}',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              if (cartItems.contains(cartProduct)) {
                                context
                                    .read<ProductProvider>()
                                    .cartDelete(cartProduct);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Delete from cart successfully'),
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  backgroundColor: Colors.green,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Sorry!! Item not available in cart'),
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
