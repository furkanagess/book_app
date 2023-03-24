import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_app/feature/detail/book_detail_view.dart';
import 'package:book_app/product/extensions/context_extension.dart';
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
        centerTitle: true,
        elevation: 0,
        title: const Text('Books'),
      ),
      body: Padding(
        padding: context.paddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trendings",
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(
              height: context.dynamicHeight(0.4),
              child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.paddingLow,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailView(book: books[index]),
                        ),
                      ),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.dynamicHeight(0.3),
                              child: Image.network(
                                books[index].thumbnailUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AutoSizeText(
                              books[index].title,
                              softWrap: true,
                              maxLines: 1,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AutoSizeText(
                              books[index].author,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "For You",
              style: context.textTheme.headlineSmall,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: context.paddingLow,
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: books[index].thumbnailUrl.isNotEmpty ? Image.network(books[index].thumbnailUrl) : const Icon(Icons.book),
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
            ),
          ],
        ),
      ),
    );
  }
}
