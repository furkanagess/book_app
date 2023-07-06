// ignore_for_file: non_constant_identifier_names

import 'package:book_app/feature/search/viewModel/book_search_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/routes/app_routes.dart';
import 'package:book_app/product/widgets/container/book_info_container.dart';
import 'package:book_app/product/widgets/textField/stadium_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookSearchView extends StatefulWidget {
  const BookSearchView({super.key});

  @override
  State<BookSearchView> createState() => _BookSearchViewState();
}

class _BookSearchViewState extends State<BookSearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<BookSearchViewModel>(
      viewModel: BookSearchViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, BookSearchViewModel viewModel) {
        final bookSearchViewModel = Provider.of<BookSearchViewModel>(context);
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: buildAppBar(),
          body: Column(
            children: [
              SearchBar(searchController: _searchController, bookSearchViewModel: bookSearchViewModel),
              SearchedBookList(bookSearchViewModel),
            ],
          ),
        );
      },
    );
  }

  Expanded SearchedBookList(BookSearchViewModel bookSearchViewModel) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bookSearchViewModel.books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final book = bookSearchViewModel.books[index];
            return BookInfoContainer(
              onTap: () {
                AppRoutes().navigateToDetail(context, book);
              },
              img: bookSearchViewModel.books[index].thumbnailUrl == ""
                  ? Icon(
                      Icons.book,
                      size: 150,
                      color: AppColors.green,
                    )
                  : Image.network(
                      bookSearchViewModel.books[index].thumbnailUrl,
                      fit: BoxFit.fill,
                      width: context.dynamicWidth(0.4),
                      height: context.dynamicHeight(0.22),
                    ),
              bgColor: AppColors.darkWhite,
              title: book.title,
              subColor: AppColors.darkGrey,
              subText: book.author,
              titleColor: AppColors.white,
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: const Text(
        AppStrings.search,
      ),
      centerTitle: true,
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required TextEditingController searchController,
    required this.bookSearchViewModel,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final BookSearchViewModel bookSearchViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: StadiumCustomTextField(
        controller: _searchController,
        hintText: AppStrings.searchFBooks,
        defaultColor: AppColors.green,
        hintColor: AppColors.background,
        iconTap: () {
          final query = _searchController.text;
          bookSearchViewModel.searchBooks(query);
        },
        onSubmit: () {
          final query = _searchController.text;
          bookSearchViewModel.searchBooks(query);
        },
      ),
    );
  }
}
