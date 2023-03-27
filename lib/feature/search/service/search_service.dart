import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchService {
  static const String searchUrl = 'https://www.googleapis.com/books/v1/volumes';

  static Future<List<dynamic>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$searchUrl?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['items'] ?? [];
    } else {
      throw Exception('Failed to search books');
    }
  }
}
