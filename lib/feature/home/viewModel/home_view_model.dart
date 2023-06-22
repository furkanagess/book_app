// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
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

  Future<void> fetchBooks() async {
    await fetchTrendingBooks();
    await fetchBestsellerBooks();
  }

  Future<void> fetchTrendingBooks() async {
    isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(ApiUrl.trending));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksData = data['items'];
      _trendingBooks = booksData.map((bookData) => Book.fromJson(bookData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch trending books');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBestsellerBooks() async {
    isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(ApiUrl.bestseller));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksData = data['items'];
      _bestsellerBooks = booksData.map((bookData) => Book.fromJson(bookData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch bestseller books');
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
