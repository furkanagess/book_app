import 'dart:convert';

import 'package:book_app/feature/home/viewModel/home_view_model.dart';

import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/constants/app_colors.dart';
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
        backgroundColor: AppColors().background,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: context.paddingLowHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerRow(context),
                SizedBox(height: context.dynamicHeight(0.05)),
                trendingsHeaderRow(context),
                TrendingsListview(books: books),
                SizedBox(height: context.dynamicHeight(0.05)),
                recommendedHeaderRow(context),
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
                                child: books[index] == null
                                    ? const Icon(Icons.book)
                                    : Image.network(
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

  Row recommendedHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.recommended,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors().white,
          ),
        ),
        Text(
          AppStrings.seeMore,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors().white,
          ),
        ),
      ],
    );
  }

  Row trendingsHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.trending,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors().white,
          ),
        ),
        Text(
          AppStrings.seeMore,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors().white,
          ),
        ),
      ],
    );
  }

  Row headerRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Merhaba İyi Günler",
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors().white,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.sort,
            color: AppColors().white,
          ),
        ),
        IconButton(
          padding: const EdgeInsets.only(left: 16),
          onPressed: () {},
          icon: Icon(
            Icons.manage_search,
            color: AppColors().white,
          ),
        ),
        SizedBox(
          width: context.dynamicWidth(0.06),
        )
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppStrings.discover,
        style: context.textTheme.headlineSmall?.copyWith(
          color: AppColors().white,
        ),
      ),
    );
  }
}

class TrendingsListview extends StatelessWidget {
  const TrendingsListview({
    super.key,
    required this.books,
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
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
                                books[index].title,
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: AppColors().white,
                                ),
                              ),
                              SizedBox(height: context.dynamicHeight(0.02)),
                              Text(
                                books[index].author,
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
    );
  }
}
