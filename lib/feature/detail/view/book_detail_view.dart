import 'package:book_app/feature/detail/viewModel/book_detail_view_model.dart';
import 'package:book_app/feature/favorite/viewModel/favorite_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/widgets/container/paragraph_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: AppColors.background,
        appBar: buildAppbar(),
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
                description: book.description == "" ? AppStrings.placeholderText : book.description,
              ),
            ],
          ),
        ),
        floatingActionButton: fabButton(context),
      ),
    );
  }

  FloatingActionButton fabButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColors.green,
      onPressed: () {
        final favoriteViewModel = Provider.of<FavoriteViewModel>(context, listen: false);
        favoriteViewModel.addBook(book);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(AppStrings.addFavorite),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Icon(
        Icons.favorite,
        color: AppColors.darkWhite,
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        book.title,
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
        child: book.thumbnailUrl == ""
            ? Icon(
                Icons.book,
                size: 250,
                color: AppColors.green,
              )
            : Image.network(
                book.thumbnailUrl,
                fit: BoxFit.fill,
                height: 250,
                width: 200,
              ),
      ),
    );
  }
}
