import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatelessWidget {
  final Book book;

  const BookDetailView({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.thumbnailUrl),
            SizedBox(height: 16.0),
            Text(
              'Title: ${book.title}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Author(s): ${book.author}'),
            SizedBox(height: 8.0),
            Text('Description: ${book.description}'),
          ],
        ),
      ),
    );
  }
}
