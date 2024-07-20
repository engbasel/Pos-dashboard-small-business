import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoustomTextFormFiled extends StatelessWidget {
  CoustomTextFormFiled({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false, // Default to false if not provided
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  void Function()? onTap;
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
