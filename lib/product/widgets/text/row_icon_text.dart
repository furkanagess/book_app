import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

@immutable
class IconTextRow extends StatelessWidget {
  final Color textColor;
  final Color iconColor;
  final String text;
  final IconData icon;
  const IconTextRow({
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
