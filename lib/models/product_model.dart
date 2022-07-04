import 'dart:io';

class Product {
  final String productName, productColor;
  final File productImgPath;
  final double productPrice;

  Product(
      {required this.productName,
      required this.productPrice,
      required this.productColor,
      required this.productImgPath});
}

Map<String, Product> mappedObject = {
  '1': Product(
      productName: 'productName',
      productPrice: 1,
      productColor: 'productColor',
      productImgPath: 'jshadjh' as File),
};
