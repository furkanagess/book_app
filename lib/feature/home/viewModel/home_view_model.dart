// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/feature/home/service/home_service.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  bool isLoading = false;
  List<Book> _trendingBooks = [];
  List<Book> _bestsellerBooks = [];

  List<Book> get trendingBooks => _trendingBooks;
  List<Book> get bestsellerBooks => _bestsellerBooks;
  final HomeService homeService = HomeService();
  Future<void> fetchBooks() async {
    await fetchTrendingBooks();
    await fetchBestsellerBooks();
  }

  Future<void> fetchTrendingBooks() async {
    isLoading = true;
    notifyListeners();
    try {
      _trendingBooks = await homeService.fetchTrendingBooks();
    } catch (e) {
      return print('Failed to fetch trending books: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBestsellerBooks() async {
    isLoading = true;
    notifyListeners();
    try {
      _bestsellerBooks = await homeService.fetchBestsellerBooks();
    } catch (e) {
      return print('Failed to fetch trending books: $e');
    }
    isLoading = false;
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
