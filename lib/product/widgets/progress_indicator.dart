// ignore_for_file: must_be_immutable

import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  String text;
  Color indicatorColor;

  CustomProgressIndicator({
    super.key,
    required this.text,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(color: indicatorColor),
        ),
        SizedBox(height: context.dynamicHeight(0.05)),
        Padding(
          padding: context.paddingMediumHorizontal,
          child: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(color: indicatorColor),
          ),
        )
      ],
    );
  }
}
