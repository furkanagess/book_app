import 'dart:convert';

import 'package:book_app/feature/home/viewModel/home_view_model.dart';

import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
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
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewModel homeViewModel) => Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: context.paddingLowHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.2),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.amberAccent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: context.paddingLow,
                              child: Text(
                                AppStrings.welcome,
                                style: context.textTheme.headlineSmall,
                              ),
                            ),
                            Padding(
                              padding: context.paddingLow,
                              child: Text(
                                AppStrings.subHeader,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                      AppStrings.trending,
                      style: context.textTheme.headlineSmall,
                    ),
                    Text(
                      AppStrings.seeMore,
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
                                margin: const EdgeInsets.all(10.0),
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
                      AppStrings.recommended,
                      style: context.textTheme.headlineSmall,
                    ),
                    Text(
                      AppStrings.seeMore,
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
                                margin: const EdgeInsets.all(10.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppStrings.discover,
        style: context.textTheme.headlineSmall?.copyWith(color: Colors.black),
      ),
    );
  }
}
