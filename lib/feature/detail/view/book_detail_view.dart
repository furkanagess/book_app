import 'package:book_app/feature/detail/viewModel/book_detail_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/widgets/appbar/custom_appbar.dart';
import 'package:book_app/product/widgets/container/paragraph_container.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatelessWidget {
  final Book book;

  const BookDetailView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BaseView<BookDetailViewModel>(
      viewModel: BookDetailViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, BookDetailViewModel viewModel) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: CustomAppBar(
          title: Text(
            book.title,
          ),
        ),
        body: Padding(
          padding: context.paddingLowHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderBookImage(book: book),
              ParapgraphContainer(
                bgColor: AppColors.darkWhite,
                textColor: AppColors.white,
                title: AppStrings.description,
                description: book.description.isEmpty ? AppStrings.placeholderText : book.description,
              ),
            ],
          ),
        ),
        floatingActionButton: fabButton(context, viewModel),
      ),
    );
  }

  FloatingActionButton fabButton(BuildContext context, BookDetailViewModel viewModel) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColors.green,
      onPressed: () {
        viewModel.addBook(book);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: const StadiumBorder(),
            behavior: SnackBarBehavior.floating,
            content: const Text(AppStrings.addFavorite),
            duration: context.highDuration,
          ),
        );
      },
      child: Icon(
        Icons.favorite,
        color: AppColors.darkWhite,
      ),
    );
  }
}

class HeaderBookImage extends StatelessWidget {
  const HeaderBookImage({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: AppColors.darkWhite,
        margin: const EdgeInsets.all(10.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: book.thumbnailUrl.isEmpty
            ? Icon(
                Icons.book,
                size: 250, // replace with enum
                color: AppColors.green,
              )
            : Image.network(
                book.thumbnailUrl,
                fit: BoxFit.fill,
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(0.22),
              ),
      ),
    );
  }
}
