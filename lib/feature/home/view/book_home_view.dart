import 'dart:convert';

import 'package:book_app/feature/home/viewModel/home_view_model.dart';

import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/api_types.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/widgets/container/book_info_container.dart';
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
                TrendingsListview(books: books),
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
          AppStrings.homeHeader,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors().white,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
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
          return BookInfoContainer(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailView(book: books[index]),
              ),
            ),
            img: books[index].thumbnailUrl == ""
                ? Icon(
                    Icons.book,
                    size: 150,
                    color: AppColors().green,
                  )
                : Image.network(
                    books[index].thumbnailUrl,
                    fit: BoxFit.fill,
                    height: 200,
                    width: 200,
                  ),
            bgColor: AppColors().darkWhite,
            title: books[index].title,
            subColor: AppColors().darkGrey,
            subText: books[index].author,
            titleColor: AppColors().white,
          );
        },
      ),
    );
  }
}
