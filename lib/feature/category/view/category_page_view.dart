import 'dart:convert';
import 'package:book_app/feature/category/categoryList/view/category_list_view.dart';
import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
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
        backgroundColor: AppColors().background,
        appBar: AppBar(
          backgroundColor: AppColors().transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.categories,
            style: context.textTheme.headlineSmall?.copyWith(
              color: AppColors().white,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: context.dynamicHeight(0.05)),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookListView(category),
                            ),
                          );
                        },
                        child: Container(
                          width: context.dynamicWidth(0.42),
                          height: context.dynamicHeight(0.25),
                          decoration: BoxDecoration(
                            color: AppColors().green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              category.name,
                              style: context.textTheme.titleLarge?.copyWith(color: AppColors().white),
                            ),
                          )),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        // ListView.builder(
        //   itemCount: _categories.length,
        //   itemBuilder: (context, index) {
        //     final category = _categories[index];
        //     return ListTile(
        //       title: Text(category.name),
        //       onTap: () {
        //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookListView(category)));
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
