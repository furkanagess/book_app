import 'package:book_app/feature/favorite/provider/favorite_provider.dart';
import 'package:book_app/feature/favorite/viewModel/favorite_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBooksView extends StatelessWidget {
  const FavoriteBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteBooks = Provider.of<FavoriteBooks>(context);

    return BaseView<FavoriteViewModel>(
      viewModel: FavoriteViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.myFavoriteBooks,
          ),
        ),
        body: ListView.builder(
          itemCount: favoriteBooks.books.length,
          itemBuilder: (context, index) {
            final book = favoriteBooks.books[index];
            return ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  favoriteBooks.removeBook(book);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
