import 'package:book_app/feature/search/viewModel/book_search_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
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
        final bookListViewModel = Provider.of<BookSearchViewModel>(context);
        return Scaffold(
          backgroundColor: AppColors().background,
          appBar: buildAppBar(),
          body: Column(
            children: [
              Padding(
                padding: context.paddingNormal,
                child: StadiumCustomTextField(
                  controller: _searchController,
                  hintText: AppStrings.searchFBooks,
                  defaultColor: AppColors().green,
                  hintColor: AppColors().background,
                  iconTap: () {
                    final query = _searchController.text;
                    bookListViewModel.searchBooks(query);
                  },
                  onSubmit: () {
                    final query = _searchController.text;
                    bookListViewModel.searchBooks(query);
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookListViewModel.books.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      final book = bookListViewModel.books[index];
                      return BookInfoContainer(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BookDetailView(book: book),
                            ),
                          );
                        },
                        img: bookListViewModel.books[index].thumbnailUrl == ""
                            ? Icon(
                                Icons.book,
                                size: 150,
                                color: AppColors().green,
                              )
                            : Image.network(
                                bookListViewModel.books[index].thumbnailUrl,
                                fit: BoxFit.fill,
                                height: 200,
                                width: 200,
                              ),
                        bgColor: AppColors().darkWhite,
                        title: book.title,
                        subColor: AppColors().darkGrey,
                        subText: book.author,
                        titleColor: AppColors().white,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    // return BaseView<SearchViewModel>(
    //   viewModel: SearchViewModel(),
    //   onModelReady: (model) {
    //     model.setContext(context);
    //   },
    //   onPageBuilder: (context, value) => Scaffold(
    //     backgroundColor: AppColors().background,
    //     appBar: buildAppBar(),
    //     body: Column(
    //       children: [
    //         Padding(
    //           padding: context.paddingNormal,
    //           child: StadiumCustomTextField(
    //             controller: _searchController,
    //             hintText: AppStrings.searchFBooks,
    //             defaultColor: AppColors().green,
    //             hintColor: AppColors().background,
    //             iconTap: _searchBooks,
    //             onSubmit: () => _searchBooks(),
    //           ),
    //         ),
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: GridView.builder(
    //               shrinkWrap: true,
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemCount: _books.length,
    //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 childAspectRatio: 0.6,
    //                 crossAxisCount: 2,
    //                 crossAxisSpacing: 1,
    //                 mainAxisSpacing: 20,
    //               ),
    //               itemBuilder: (context, index) {
    //                 final book = _books[index];
    //                 return BookInfoContainer(
    //                   onTap: () {
    //                     Navigator.of(context).push(
    //                       MaterialPageRoute(
    //                         builder: (_) => BookDetailView(book: book),
    //                       ),
    //                     );
    //                   },
    //                   img: _books[index].thumbnailUrl == ""
    //                       ? Icon(
    //                           Icons.book,
    //                           size: 150,
    //                           color: AppColors().green,
    //                         )
    //                       : Image.network(
    //                           _books[index].thumbnailUrl,
    //                           fit: BoxFit.fill,
    //                           height: 200,
    //                           width: 200,
    //                         ),
    //                   bgColor: AppColors().darkWhite,
    //                   title: book.title,
    //                   subColor: AppColors().darkGrey,
    //                   subText: book.author,
    //                   titleColor: AppColors().white,
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors().background,
      elevation: 0,
      title: const Text(
        AppStrings.search,
      ),
      centerTitle: true,
    );
  }
}
