import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType kType;
  // final Function(String) validator;
  const FormWidget(
      {Key? key,
      required this.controller,
      required this.label,
      required this.kType
      // required this.validator
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: kType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Enter $label',
        label: Text(label),
      ),
      validator: (dynamic value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
