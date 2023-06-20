import 'dart:convert';

import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api_types.dart';

class BookService extends ChangeNotifier {
  List<Book> books = [];
  List<BookCategory> categories = [];
  bool isLoading = false;
  List<Book> _trendingBooks = [];
  List<Book> _bestsellerBooks = [];

  List<Book> get trendingBooks => _trendingBooks;
  List<Book> get bestsellerBooks => _bestsellerBooks;

  // Category Page

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

  Future<void> fetchBooksByCategory(String category) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.categoryDetail + category),
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

  // Favorite Page

  void addBook(Book book) {
    books.add(book);
    notifyListeners();
  }

  void removeBook(Book book) {
    books.remove(book);
    notifyListeners();
  }

  // Search Page

  Future<List<Book>> searchBooks(String query) async {
    final url = Uri.https(
      ApiUrl.googleApis,
      ApiUrl.v1Volumes,
      {'q': query},
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksJson = data['items'];
      return booksJson.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Home Page

  Future<void> fetchBooks() async {
    await fetchTrendingBooks();
    await fetchBestsellerBooks();
  }

  Future<void> fetchTrendingBooks() async {
    final response = await http.get(Uri.parse(ApiUrl.trending));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksData = data['items'];
      _trendingBooks = booksData.map((bookData) => Book.fromJson(bookData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch trending books');
    }
  }

  Future<void> fetchBestsellerBooks() async {
    final response = await http.get(Uri.parse(ApiUrl.bestseller));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksData = data['items'];
      _bestsellerBooks = booksData.map((bookData) => Book.fromJson(bookData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch bestseller books');
    }
  }
}
