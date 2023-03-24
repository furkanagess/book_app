import 'dart:convert';

import 'package:book_app/feature/detail/book_detail_view.dart';
import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookHomeView extends StatefulWidget {
  const BookHomeView({super.key});

  @override
  State<BookHomeView> createState() => _BookHomeViewState();
}

class _BookHomeViewState extends State<BookHomeView> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter%20development'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        books = List<Book>.from(json['items'].map((bookJson) => Book.fromJson(bookJson)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Text("data"),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: books[index].thumbnailUrl.isNotEmpty ? Image.network(books[index].thumbnailUrl) : Icon(Icons.book),
                  title: Text(books[index].title),
                  subtitle: Text(books[index].author),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailView(book: books[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
