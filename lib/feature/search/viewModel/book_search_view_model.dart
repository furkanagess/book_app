import 'package:book_app/feature/search/service/search_book_service.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'book_search_view_model.g.dart';

class BookSearchViewModel = _BookSearchViewModelBase with _$BookSearchViewModel;

abstract class _BookSearchViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  final SearchBookService _newBookService = SearchBookService();
  List<Book> _books = [];
  List<Book> get books => _books;

  Future<void> searchBooks(String query) async {
    final books = await _newBookService.searchBooks(query);
    _books = books;
    notifyListeners();
  }
}
