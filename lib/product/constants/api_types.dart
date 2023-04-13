import 'package:flutter/material.dart';

@immutable
class ApiUrl {
  const ApiUrl._();
  static const String flutterDev = 'https://www.googleapis.com/books/v1/volumes?q=flutter%20development';
  static const String programming = 'https://www.googleapis.com/books/v1/volumes?q=programming';
  static const String trending = 'https://www.googleapis.com/books/v1/volumes?q=trending';
}
