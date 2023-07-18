// ignore_for_file: must_be_immutable

import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class BookInfoContainer extends StatelessWidget {
  BookInfoContainer({
    super.key,
    required this.onTap,
    required this.img,
    required this.bgColor,
    required this.title,
    required this.subColor,
    required this.subText,
    required this.titleColor,
  });
  final Function() onTap;
  final Color bgColor;
  final Color titleColor;
  final Color subColor;
  final String title;
  final String subText;

  Widget img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: context.dynamicWidth(0.45),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bgColor,
          ),
          child: Padding(
            padding: context.paddingLow,
            child: Column(
              children: [
                Card(
                  color: AppColors.background,
                  margin: const EdgeInsets.all(10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: img,
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: titleColor,
                          ),
                        ),
                        SizedBox(height: context.dynamicHeight(0.02)),
                        Text(
                          subText,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: subColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
