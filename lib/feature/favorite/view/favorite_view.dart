import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/feature/favorite/provider/favorite_provider.dart';
import 'package:book_app/feature/favorite/viewModel/favorite_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBooksView extends StatelessWidget {
  const FavoriteBooksView({super.key});
//
  @override
  Widget build(BuildContext context) {
    final favoriteBooks = Provider.of<FavoriteBooks>(context);
    return BaseView<FavoriteViewModel>(
      viewModel: FavoriteViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        backgroundColor: AppColors().background,
        appBar: AppBar(
          backgroundColor: AppColors().background,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            AppStrings.myFavoriteBooks,
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favoriteBooks.books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6,
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final book = favoriteBooks.books[index];
                  return Padding(
                    padding: context.paddingLow,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailView(book: book),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors().darkWhite,
                        ),
                        child: Padding(
                          padding: context.paddingLow,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 11,
                                child: Card(
                                  color: AppColors().background,
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
                                          size: 150,
                                          color: AppColors().green,
                                        )
                                      : Image.network(
                                          book.thumbnailUrl,
                                          fit: BoxFit.fill,
                                          height: 200,
                                          width: 200,
                                        ),
                                ),
                              ),
                              SizedBox(height: context.dynamicHeight(0.01)),
                              Expanded(
                                flex: 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: context.textTheme.titleSmall?.copyWith(
                                          color: AppColors().white,
                                        ),
                                      ),
                                      SizedBox(height: context.dynamicHeight(0.02)),
                                      Text(
                                        book.author,
                                        style: context.textTheme.bodyLarge?.copyWith(
                                          color: AppColors().darkGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    favoriteBooks.removeBook(book);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors().green,
                                  ),
                                ),
                              ),
                              SizedBox(height: context.dynamicHeight(0.01)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
