import 'package:book_app/product/models/book.dart';

import 'package:flutter/material.dart';

class FavoriteBooks extends ChangeNotifier {
  final List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void removeBook(Book book) {
    _books.remove(book);
    notifyListeners();
  }
}
