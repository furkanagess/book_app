// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book_category.dart';
import 'package:book_app/product/routes/app_routes.dart';
import 'package:book_app/product/widgets/appbar/custom_appbar.dart';
import 'package:book_app/product/widgets/container/book_info_container.dart';
import 'package:book_app/product/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCategoriesDetailPage extends StatelessWidget {
  final BookCategory category;

  BookCategoriesDetailPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final bookModel = Provider.of<CategoryViewModel>(context);
    return BaseView<CategoryViewModel>(
      viewModel: CategoryViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, CategoryViewModel viewModel) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Text(category.name),
          ),
          body: bookModel.isLoading
              ? CustomProgressIndicator(text: AppStrings.wait, indicatorColor: AppColors.green)
              : SafeArea(
                  child: ListView(
                    children: [
                      CategoryBookGrid(bookModel: bookModel),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class CategoryBookGrid extends StatelessWidget {
  const CategoryBookGrid({
    super.key,
    required this.bookModel,
  });

  final CategoryViewModel bookModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookModel.books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final book = bookModel.books[index];
        return BookInfoContainer(
          onTap: () {
            AppRoutes().navigateToDetail(context, book);
          },
          img: book.thumbnailUrl == ""
              ? Icon(
                  Icons.book,
                  size: 150,
                  color: AppColors.green,
                )
              : Image.network(
                  book.thumbnailUrl,
                  fit: BoxFit.fill,
                  width: context.dynamicWidth(0.4),
                  height: context.dynamicHeight(0.22),
                ),
          bgColor: AppColors.darkWhite,
          title: book.title,
          subColor: AppColors.darkGrey,
          subText: book.author,
          titleColor: AppColors.white,
        );
      },
    );
  }
}
