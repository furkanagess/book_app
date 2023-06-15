import 'dart:convert';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/models/book.dart';
import 'package:http/http.dart' as http;

class SearchBookService {
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
}
