// ignore_for_file: must_be_immutable

import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  Function() onTap;
  Color bgColor;
  Color textColor;
  String text;
  HeaderContainer({
    super.key,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.dynamicWidth(0.42),
        height: context.dynamicHeight(0.20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: context.textTheme.titleLarge?.copyWith(
              color: textColor,
            ),
          ),
        )),
      ),
    );
  }
}
