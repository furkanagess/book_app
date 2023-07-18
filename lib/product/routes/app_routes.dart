import 'package:book_app/feature/category/categoryDetail/view/categories_detail_view.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/feature/favorite/view/favorite_view.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/book_category.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  void navigateToCategory(BuildContext context, BookCategory bookCategory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookCategoriesDetailPage(category: bookCategory),
      ),
    );
  }

  void navigateToDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailView(
          book: book,
        ),
      ),
    );
  }

  void navigateToFavorite(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoriteBooksView(),
      ),
    );
  }
}
