import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_app/feature/category/view/category_page_view.dart';

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
    final response = await http.get(Uri.parse(ApiUrl.programming));
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover Books",
                style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: context.dynamicHeight(0.2),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.amberAccent,
                  child: ListTile(
                    title: Text("Enjoy your reaading"),
                    subtitle: Text("You can easily reach" * 10),
                  ),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.05),
              ),
              Text(
                "Trendings",
                style: context.textTheme.headlineSmall,
              ),
              SizedBox(
                height: context.dynamicHeight(0.3),
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.dynamicHeight(0.25),
                            child: Card(
                              margin: EdgeInsets.all(10.0),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                books[index].thumbnailUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text(
                "Recommended For You",
                style: context.textTheme.headlineSmall,
              ),
              SizedBox(
                height: context.dynamicHeight(0.3),
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.dynamicHeight(0.25),
                            child: Card(
                              margin: EdgeInsets.all(10.0),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                books[index].thumbnailUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookCategoriesView(),
                        ),
                      );
                    },
                    child: const Text("Go to Categories"),
                  ),
                ],
              ),
            ],
          ),
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
        'Home Page',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
