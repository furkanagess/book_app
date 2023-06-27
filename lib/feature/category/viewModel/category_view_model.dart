// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:book_app/feature/category/service/category_service.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'category_view_model.g.dart';

class CategoryViewModel = _CategoryViewModelBase with _$CategoryViewModel;

abstract class _CategoryViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  List<Book> books = [];
  List<BookCategory> categories = [];
  bool isLoading = false;
  final CategoryService _categoryService = CategoryService();

  Future<void> fetchBookCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      categories = await _categoryService.fetchBookCategories();
    } catch (e) {
      return print('Failed to fetch trending books: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByCategory(String category) async {
    isLoading = true;
    notifyListeners();

    try {
      books = await _categoryService.fetchBooksByCategory(category);
    } catch (e) {
      return print('Failed to fetch trending books: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
