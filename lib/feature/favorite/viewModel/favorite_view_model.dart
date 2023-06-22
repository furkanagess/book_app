// ignore_for_file: library_private_types_in_public_api

import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../detail/view/book_detail_view.dart';

part 'favorite_view_model.g.dart';

class FavoriteViewModel = _FavoriteViewModelBase with _$FavoriteViewModel;

abstract class _FavoriteViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
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

  void navigateToDetail(BuildContext context, Book books) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailView(
          book: books,
        ),
      ),
    );
  }
}
