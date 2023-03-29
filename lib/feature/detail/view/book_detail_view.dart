import 'package:book_app/product/models/book.dart';

import 'package:book_app/feature/favorite/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailView extends StatelessWidget {
  final Book book;

  const BookDetailView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'by ${book.author}',
            style: TextStyle(fontSize: 18),
          ),
          Text(book.description),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final favoriteBooks = Provider.of<FavoriteBooks>(context, listen: false);
          favoriteBooks.addBook(book);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to favorites')));
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}
