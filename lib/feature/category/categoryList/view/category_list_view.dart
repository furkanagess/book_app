// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:convert';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookListPage extends StatefulWidget {
  final BookCategory category;

  BookListPage(this.category);

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=subject:${widget.category.name}'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        _books = List<Map<String, dynamic>>.from(body['items'])
            .map((item) => Book(
                  title: item['volumeInfo']['title'],
                  author: item['volumeInfo']['authors']?.join(', ') ?? 'Unknown Author',
                  description: item['volumeInfo']['description'] ?? '',
                  thumbnailUrl: '',
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_books == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookDetailView(book: _books[index])));
            },
          );
        },
      ),
    );
  }
}
