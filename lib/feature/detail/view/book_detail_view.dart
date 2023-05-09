import 'package:book_app/product/extensions/context_extension.dart';
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
      appBar: buildAppbar(),
      body: Padding(
        padding: context.paddingLow,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.5),
                child: Card(
                  shadowColor: Colors.amberAccent,
                  margin: const EdgeInsets.all(10.0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    book.thumbnailUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                book.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'by ${book.author}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(book.description),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          final favoriteBooks = Provider.of<FavoriteBooks>(context, listen: false);
          favoriteBooks.addBook(book);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Added to favorites'),
          ));
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        book.title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
