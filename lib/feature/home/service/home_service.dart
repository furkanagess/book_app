import 'dart:convert';

import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/models/book.dart';
import 'package:http/http.dart' as http;

class HomeService {
  List<Book> _trendingBooks = [];
  List<Book> _bestsellerBooks = [];

  List<Book> get trendingBooks => _trendingBooks;
  List<Book> get bestsellerBooks => _bestsellerBooks;

  Future<List<Book>> fetchTrendingBooks() async {
    final response = await http.get(Uri.parse(ApiUrl.trending));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksData = data['items'];
      _trendingBooks = booksData.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Failed to fetch trending books');
    }
    return _trendingBooks;
  }

  Future<List<Book>> fetchBestsellerBooks() async {
    final response = await http.get(Uri.parse(ApiUrl.bestseller));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksData = data['items'];
      _bestsellerBooks = booksData.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Failed to fetch bestseller books');
    }
    return _bestsellerBooks;
  }
}
