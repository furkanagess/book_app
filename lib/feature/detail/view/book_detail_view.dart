import 'package:book_app/feature/detail/viewModel/book_detail_view_model.dart';
import 'package:book_app/feature/favorite/view/favorite_view.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';

import 'package:book_app/feature/favorite/provider/favorite_provider.dart';
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
      onPageBuilder: (context, value) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: AppColors().background,
        appBar: buildAppbar(),
        body: Padding(
          padding: context.paddingLowHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Card(
                  color: AppColors().darkWhite,
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
                          color: AppColors().green,
                        )
                      : Image.network(
                          book.thumbnailUrl,
                          fit: BoxFit.fill,
                          height: 250,
                          width: 200,
                        ),
                ),
              ),
              Container(
                height: context.dynamicHeight(0.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors().darkWhite,
                ),
                child: Padding(
                  padding: context.paddingNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.dynamicHeight(0.01)),
                      Text(
                        "Description",
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: AppColors().white,
                        ),
                      ),
                      SizedBox(height: context.dynamicHeight(0.01)),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                                child: Column(
                                  children: [
                                    Text(
                                      book.description == "" ? AppStrings.placeholderText : book.description,
                                      style: context.textTheme.titleSmall?.copyWith(
                                        color: AppColors().white,
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: AppColors().green,
          onPressed: () {
            final favoriteBooks = Provider.of<FavoriteBooks>(context, listen: false);
            favoriteBooks.addBook(book);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              shape: StadiumBorder(),
              action: SnackBarAction(
                backgroundColor: AppColors().darkGrey,
                textColor: AppColors().green,
                label: "Favorilerim",
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteBooksView(),
                    )),
              ),
              content: Text('${book.title}  added to favorites'),
            ));
          },
          child: Icon(Icons.favorite, color: AppColors().darkWhite),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        book.title,
      ),
    );
  }
}
