import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_project2/provider/product_provider.dart';
import 'package:provider_project2/screens/product_list.dart';
import 'package:provider_project2/widgets/form_widget.dart';
import '../models/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pName = TextEditingController();
  TextEditingController pPrice = TextEditingController();
  TextEditingController pColor = TextEditingController();

  File? imageFile;
  ImagePicker imagePicker = ImagePicker();

  Future<void> _chooseImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    //print(image);

    setState(() {
      imageFile = File(image!.path);
      // print('img path: $imageFile');
      // print(imageFile.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    //var products = context.watch<ProductProvider>().productList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Screen'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Add Nike Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                imageFile == null
                    ? Container(
                        width: double.infinity,
                        height: 250.0,
                        color: Colors.grey,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _chooseImage();
                            },
                            child: const Text("Choose image"),
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _chooseImage();
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 250.0,
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.contain,
                          ),
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //     image: FileImage(imageFile!),
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                FormWidget(
                  controller: pName,
                  label: 'Product name',
                  kType: TextInputType.name,
                ),
                const SizedBox(
                  height: 15,
                ),
                FormWidget(
                  controller: pPrice,
                  label: 'Product price',
                  kType: TextInputType.number,
                ),
                const SizedBox(
                  height: 15,
                ),
                FormWidget(
                  kType: TextInputType.text,
                  controller: pColor,
                  label: 'Product color',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (imageFile != null) {
                          if (_formKey.currentState!.validate()) {
                            Product prodObj = Product(
                                productName: pName.text,
                                productColor: pColor.text,
                                productPrice: double.parse(pPrice.text),
                                productImgPath: imageFile!);

                            context.read<ProductProvider>().productSet(prodObj);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Product info added'),
                              duration: Duration(
                                seconds: 3,
                              ),
                              backgroundColor: Colors.green,
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please insert fields!!!'),
                            duration: Duration(
                              seconds: 3,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: const Text('Add Product'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductList()));
                      },
                      child: const Text('Display Product'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
