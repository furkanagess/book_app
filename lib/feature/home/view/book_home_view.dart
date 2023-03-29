import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:book_app/feature/search/view/book_search_view.dart';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/feature/favorite/view/favorite.dart';
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
    final response = await http.get(Uri.parse(ApiUrl.flutterDev));
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
      appBar: _buildAppBar(),
      body: Padding(
        padding: context.paddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Expanded(
              flex: 1,
              child: Text(
                "Trendings",
                style: context.textTheme.headlineSmall,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailView(book: books[index]),
                      ),
                    ),
                    child: Card(
                      elevation: 5,
                      child: Image.network(
                        books[index].thumbnailUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Expanded(
              flex: 1,
              child: Text(
                "Trendings",
                style: context.textTheme.headlineSmall,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailView(book: books[index]),
                      ),
                    ),
                    child: Card(
                      elevation: 5,
                      child: Image.network(
                        books[index].thumbnailUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Expanded(
              flex: 1,
              child: Text(
                "Trendings",
                style: context.textTheme.headlineSmall,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailView(book: books[index]),
                      ),
                    ),
                    child: Card(
                      elevation: 5,
                      child: Image.network(
                        books[index].thumbnailUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookSearchView(),
                        ),
                      );
                    },
                    child: const Text("Go to Search"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoriteBooksView(),
                        ),
                      );
                    },
                    child: const Text("Go to Favorite"),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      title: const Text(
        'Books',
        style: TextStyle(color: Colors.orange),
      ),
    );
  }
}
