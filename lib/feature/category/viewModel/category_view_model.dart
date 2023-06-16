import 'dart:convert';

import 'package:book_app/product/base/base_view_model.dart';
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
  List<BookCategory> categories = [];
  bool isLoading = false;

  Future<void> fetchBookCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=all'),
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
}
