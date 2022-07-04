import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project2/models/product_model.dart';
import 'package:provider_project2/screens/cart_list_screen.dart';
import '../provider/product_provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var products = context.watch<ProductProvider>().productList;
    var cart = context.watch<ProductProvider>().cartList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Screen'),
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 5, end: 5),
            badgeContent: Text(
              cart.length.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartListScreen()));
                },
                icon: const Icon(Icons.production_quantity_limits_rounded)),
          )
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: Text('No any product is available!!!'),
            )
          : GridView.builder(
              //shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1 / 1.6),
              itemBuilder: (BuildContext context, int index) {
                final Product cartProduct = products[index];
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
                          height: 150,
                          width: double.infinity,
                          child: Image.file(
                            products[index].productImgPath,
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
                                'Name: ${products[index].productName}',
                                textAlign: TextAlign.left,
                              ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              Text(
                                'Price: \$${products[index].productPrice.toString()}',
                                textAlign: TextAlign.left,
                              ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              Text(
                                'Color: ${products[index].productColor}',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (!cart.contains(cartProduct)) {
                                  context
                                      .read<ProductProvider>()
                                      .cartSet(cartProduct);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Added to cart'),
                                    duration: Duration(
                                      seconds: 1,
                                    ),
                                    backgroundColor: Colors.green,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('Sorry!! It is already in cart'),
                                    duration: Duration(
                                      seconds: 1,
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              icon: const Icon(
                                  Icons.production_quantity_limits_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
