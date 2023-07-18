import 'package:book_app/feature/favorite/viewModel/favorite_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/routes/app_routes.dart';
import 'package:book_app/product/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBooksView extends StatelessWidget {
  const FavoriteBooksView({super.key});
//
  @override
  Widget build(BuildContext context) {
    final favoriteViewModel = Provider.of<FavoriteViewModel>(context);
    return BaseView<FavoriteViewModel>(
      viewModel: FavoriteViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        appBar: const CustomAppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppStrings.myFavoriteBooks,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildFavoriteBookGrid(favoriteViewModel),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildFavoriteBookGrid(FavoriteViewModel favoriteViewModel) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: favoriteViewModel.books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final book = favoriteViewModel.books[index];
        return buildFavoriteBook(context, favoriteViewModel, book);
      },
    );
  }

  Padding buildFavoriteBook(BuildContext context, FavoriteViewModel favoriteViewModel, Book book) {
    return Padding(
      padding: context.paddingLow,
      child: GestureDetector(
        onTap: () {
          AppRoutes().navigateToDetail(context, book);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.darkWhite,
          ),
          child: Padding(
            padding: context.paddingLow,
            child: Column(
              children: [
                Expanded(
                  flex: 11,
                  child: cardImage(book, context),
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                Expanded(
                  flex: 3,
                  child: scrollableText(book, context),
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                Expanded(
                  flex: 2,
                  child: deleteButton(favoriteViewModel, book, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card cardImage(Book book, BuildContext context) {
    return Card(
      color: AppColors.background,
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
              size: 150,
              color: AppColors.green,
            )
          : Image.network(
              book.thumbnailUrl,
              fit: BoxFit.fill,
              width: context.dynamicWidth(0.4),
              height: context.dynamicHeight(0.22),
            ),
    );
  }

  SingleChildScrollView scrollableText(Book book, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: context.textTheme.titleSmall?.copyWith(
              color: AppColors.white,
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          Text(
            book.author,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  CircleAvatar deleteButton(FavoriteViewModel favoriteViewModel, Book book, BuildContext context) {
    return CircleAvatar(
      radius: 460,
      backgroundColor: AppColors.darkGrey,
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColors.white,
                title: Text(
                  AppStrings.sureDelete,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: AppColors.background,
                  ),
                ),
                actions: [
                  Card(
                    color: AppColors.green,
                    child: TextButton(
                      onPressed: () {
                        favoriteViewModel.removeBook(book);
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppStrings.delete,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.back,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          //
        },
        icon: Icon(
          Icons.delete,
          size: 20,
          color: AppColors.green,
        ),
      ),
    );
  }
}
