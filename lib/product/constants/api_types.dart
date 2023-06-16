import 'package:flutter/material.dart';

@immutable
class ApiUrl {
  const ApiUrl._();
  static const String flutterDev = 'https://www.googleapis.com/books/v1/volumes?q=flutter%20development';
  static const String programming = 'https://www.googleapis.com/books/v1/volumes?q=programming';
  static const String trending = 'https://www.googleapis.com/books/v1/volumes?q=trending';
  static const String googleApis = 'www.googleapis.com';
  static const String v1Volumes = '/books/v1/volumes';
  static const String category = 'https://www.googleapis.com/books/v1/volumes?q=red';
  static const String categoryDetail = 'https://www.googleapis.com/books/v1/volumes?q=flutter+subject:$category';
}
