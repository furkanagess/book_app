// ignore_for_file: library_private_types_in_public_api

import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'book_detail_view_model.g.dart';

class BookDetailViewModel = _BookDetailViewModelBase with _$BookDetailViewModel;

abstract class _BookDetailViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  void favoriteSnackbar() {}

  final List<Book> _books = [];

  List<Book> get books => _books;
  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }
}
