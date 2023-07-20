import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'favorite_view_model.g.dart';

class FavoriteViewModel = _FavoriteViewModelBase with _$FavoriteViewModel;

abstract class _FavoriteViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  final List<Book> _books = [];

  List<Book> get books => _books;

  void removeBook(Book book) {
    _books.remove(book);
    notifyListeners();
  }
}
