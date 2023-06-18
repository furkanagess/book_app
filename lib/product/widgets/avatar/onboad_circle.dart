import 'package:book_app/product/constants/app_colors.dart';
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
        backgroundColor: AppColors().green.withOpacity(isSelected ? 1 : 0.2),
        radius: isSelected ? 6 : 3,
      ),
    );
  }
}
