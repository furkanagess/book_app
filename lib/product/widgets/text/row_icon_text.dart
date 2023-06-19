// ignore_for_file: must_be_immutable

import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  Color textColor;
  Color iconColor;
  String text;
  IconData icon;
  IconTextRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        Text(
          text,
          style: context.textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ],
    );
  }
}
