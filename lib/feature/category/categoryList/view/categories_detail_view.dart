// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:convert';
import 'package:book_app/feature/category/categoryList/viewModel/category_list_view_model.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookCategoriesDetailPage extends StatefulWidget {
  final BookCategory category;

  BookCategoriesDetailPage(this.category);

  @override
  _BookCategoriesDetailPageState createState() => _BookCategoriesDetailPageState();
}

class _BookCategoriesDetailPageState extends State<BookCategoriesDetailPage> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=subject:${widget.category.name}'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        _books = List<Book>.from(body['items'].map((bookJson) => Book.fromJson(bookJson)));
      });
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_books == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return BaseView<CategoryListViewModel>(
      viewModel: CategoryListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        backgroundColor: AppColors().background,
        appBar: AppBar(
          title: Text(widget.category.name),
          backgroundColor: AppColors().transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: _books.length != 0
            ? SafeArea(
                child: ListView(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _books.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: context.paddingLow,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailView(book: _books[index]),
                              ),
                            ),
                            child: Container(
                              width: context.dynamicWidth(0.45),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors().darkWhite,
                              ),
                              child: Padding(
                                padding: context.paddingLow,
                                child: Column(
                                  children: [
                                    Card(
                                      color: AppColors().background,
                                      margin: const EdgeInsets.all(10.0),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: _books[index].thumbnailUrl == ""
                                          ? Icon(
                                              Icons.book,
                                              size: 150,
                                              color: AppColors().green,
                                            )
                                          : Image.network(
                                              _books[index].thumbnailUrl,
                                              fit: BoxFit.fill,
                                              height: 200,
                                              width: 200,
                                            ),
                                    ),
                                    SizedBox(height: context.dynamicHeight(0.01)),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _books[index].title,
                                              style: context.textTheme.titleSmall?.copyWith(
                                                color: AppColors().white,
                                              ),
                                            ),
                                            SizedBox(height: context.dynamicHeight(0.02)),
                                            Text(
                                              _books[index].author,
                                              style: context.textTheme.bodyLarge?.copyWith(
                                                color: AppColors().darkGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(color: AppColors().green),
                  ),
                  SizedBox(height: context.dynamicHeight(0.05)),
                  Padding(
                    padding: context.paddingMediumHorizontal,
                    child: Text(
                      AppStrings.wait,
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors().green),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
