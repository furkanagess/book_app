import 'package:book_app/feature/category/categoryDetail/view/categories_detail_view.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  void navigateToCategory(BuildContext context, BookCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookCategoriesDetailPage(category: category),
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
}
