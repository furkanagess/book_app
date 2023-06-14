// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomNormalTextfield extends StatelessWidget {
  TextEditingController controller;
  Color focusColor;
  Color defaultColor;
  Color hintColor;
  VoidCallback iconTap;
  VoidCallback onSubmit;
  String hintText;

  CustomNormalTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusColor,
    required this.defaultColor,
    required this.iconTap,
    required this.onSubmit,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: defaultColor),
      cursorColor: focusColor,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: defaultColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: defaultColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusColor,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: defaultColor,
          ),
          onPressed: iconTap,
        ),
      ),
      onSubmitted: (_) => onSubmit,
      autocorrect: true,
    );
  }
}
