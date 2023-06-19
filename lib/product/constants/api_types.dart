import 'package:flutter/material.dart';

@immutable
class ApiUrl {
  const ApiUrl._();
  // Home
  static const String bestseller = 'https://www.googleapis.com/books/v1/volumes?q=bestseller';
  static const String trending = 'https://www.googleapis.com/books/v1/volumes?q=trending';

  // Search
  static const String googleApis = 'www.googleapis.com';
  static const String v1Volumes = '/books/v1/volumes';

  // Category
  static const String category = 'https://www.googleapis.com/books/v1/volumes?q=red';
  static const String categoryDetail = 'https://www.googleapis.com/books/v1/volumes?q=flutter+subject:';
}
