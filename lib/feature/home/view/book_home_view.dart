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
    programmingBooks();
  }

  void programmingBooks() async {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowHorizontal,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: context.paddingLow,
                            child: Text(
                              "Enjoy your reading",
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          Padding(
                            padding: context.paddingLow,
                            child: Text(
                              "Enjoy your reading",
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            size: 70,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.05),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trendings",
                    style: context.textTheme.headlineSmall,
                  ),
                  Text(
                    "See more",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended",
                    style: context.textTheme.headlineSmall,
                  ),
                  Text(
                    "See more",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
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
      elevation: 0,
      leading: Icon(
        Icons.list,
        size: 30,
        color: Colors.black,
      ),
      actions: [
        Padding(
          padding: context.paddingLow,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 18,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
