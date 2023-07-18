import 'package:flutter/material.dart';

@immutable
class StadiumCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color defaultColor;
  final Color hintColor;
  final VoidCallback? iconTap;
  final VoidCallback? onSubmit;
  final String hintText;
  const StadiumCustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.defaultColor,
    this.iconTap,
    this.onSubmit,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: hintColor,
      ),
      cursorColor: hintColor,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: defaultColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        prefixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: hintColor,
            size: 30,
          ),
          onPressed: iconTap,
        ),
      ),
      onSubmitted: (_) => onSubmit,
      autocorrect: true,
    );
  }
}
