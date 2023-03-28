import 'package:book_app/product/models/book.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatefulWidget {
  final Book book;

  const BookDetailView({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.book.thumbnailUrl),
            const SizedBox(height: 16.0),
            Text(
              'Title: ${widget.book.title}',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
            const SizedBox(height: 8.0),
            Text('Author(s): ${widget.book.author}'),
            const SizedBox(height: 8.0),
            Text('Description: ${widget.book.description}'),
          ],
        ),
      ),
    );
  }
}
