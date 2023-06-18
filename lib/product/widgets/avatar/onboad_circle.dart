import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OnBoardCircle extends StatelessWidget {
  final bool isSelected;
  const OnBoardCircle({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(isSelected ? 1 : 0.2),
        radius: isSelected ? 8 : 5,
      ),
    );
  }
}
