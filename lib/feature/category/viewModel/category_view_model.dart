// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'dart:convert';

import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
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

  Future<void> fetchBookCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.category),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> items = (data['items'] as List<dynamic>).cast<dynamic>();

        categories = items
            .map((item) => BookCategory(
                  name: item['volumeInfo']['categories'] != null ? item['volumeInfo']['categories'][0] : 'Unknown Category',
                ))
            .toSet()
            .toList();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByCategory(String? category) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.categoryDetail),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> items = (data['items'] as List<dynamic>).cast<dynamic>();

        books = items
            .map((item) => Book(
                  title: item['volumeInfo']['title'] ?? 'Unknown Title',
                  thumbnailUrl: item['volumeInfo']['imageLinks'] != null ? item['volumeInfo']['imageLinks']['thumbnail'] ?? '' : '',
                  description: item['volumeInfo']['description'] ?? '',
                  author: item['volumeInfo']['authors'] != null ? item['volumeInfo']['authors'][0] ?? '' : 'Unknown Author',
                ))
            .toList();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
