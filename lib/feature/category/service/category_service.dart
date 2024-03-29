import 'dart:convert';

import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/book_category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  List<Book> _books = [];
  List<BookCategory> _categories = [];

  Future<List<BookCategory>> fetchBookCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.category),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> items = (data['items'] as List<dynamic>).cast<dynamic>();

        _categories = items
            .map((item) => BookCategory(
                  name: item['volumeInfo']['categories'] != null ? item['volumeInfo']['categories'][0] : 'Unknown Category',
                ))
            .toSet()
            .toList();
      } else {}
    } catch (e) {}
    return _categories;
  }

  Future<List<Book>> fetchBooksByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.categoryDetail + category),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> items = (data['items'] as List<dynamic>).cast<dynamic>();

        _books = items
            .map((item) => Book(
                  title: item['volumeInfo']['title'] ?? 'Unknown Title',
                  thumbnailUrl: item['volumeInfo']['imageLinks'] != null ? item['volumeInfo']['imageLinks']['thumbnail'] ?? '' : '',
                  description: item['volumeInfo']['description'] ?? '',
                  author: item['volumeInfo']['authors'] != null ? item['volumeInfo']['authors'][0] ?? '' : 'Unknown Author',
                ))
            .toList();
      } else {}
    } catch (e) {}
    return _books;
  }
}
