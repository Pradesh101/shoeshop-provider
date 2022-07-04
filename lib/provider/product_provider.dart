import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _productList = [];
  final List<Product> _cartList = [];

  productSet(Product prod) {
    _productList.add(prod);
    notifyListeners();
  }

  List<Product> get productList => _productList;

  cartSet(Product cprod) {
    _cartList.add(cprod);
    notifyListeners();
  }

  List<Product> get cartList => _cartList;

  cartDelete(Product delProd) {
    _cartList.remove(delProd);
    notifyListeners();
  }
}
