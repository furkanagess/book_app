import 'dart:convert';
import 'package:book_app/feature/category/categoryList/view/category_list_view.dart';
import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookCategoryView extends StatefulWidget {
  @override
  _BookCategoryViewState createState() => _BookCategoryViewState();
}

class _BookCategoryViewState extends State<BookCategoryView> {
  List<BookCategory> _categories = [];

  @override
  void initState() {
    super.initState();

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=all'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final categories = Set<String>();
      for (final item in body['items']) {
        if (item['volumeInfo']['categories'] != null) {
          categories.addAll(List<String>.from(item['volumeInfo']['categories']));
        }
      }
      setState(() {
        _categories = categories.map((category) => BookCategory(name: category, id: category.toLowerCase().replaceAll(' ', '-'))).toList();
      });
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_categories == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return BaseView<CategoryViewModel>(
      viewModel: CategoryViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        appBar: AppBar(
          title: const Text('Book Categories'),
        ),
        body: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return ListTile(
              title: Text(category.name),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookListView(category)));
              },
            );
          },
        ),
      ),
    );
  }
}
