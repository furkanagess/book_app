// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/models/category.dart';
import 'package:book_app/product/widgets/container/book_info_container.dart';
import 'package:book_app/product/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCategoriesDetailPage extends StatelessWidget {
  final BookCategory category;

  BookCategoriesDetailPage({required this.category});

  // List<Book> _books = [];
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
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(category.name),
            backgroundColor: AppColors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: bookModel.isLoading
              ? CustomProgressIndicator(text: AppStrings.wait, indicatorColor: AppColors.green)
              : SafeArea(
                  child: ListView(
                    children: [
                      GridView.builder(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailView(book: book),
                                ),
                              );
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
                                    height: 200,
                                    width: 200,
                                  ),
                            bgColor: AppColors.darkWhite,
                            title: book.title,
                            subColor: AppColors.darkGrey,
                            subText: book.author,
                            titleColor: AppColors.white,
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
