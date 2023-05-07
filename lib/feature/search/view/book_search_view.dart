import 'package:book_app/feature/search/service/search_service.dart';
import 'package:book_app/feature/search/viewModel/search_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:flutter/material.dart';

class BookSearchView extends StatefulWidget {
  const BookSearchView({super.key});

  @override
  State<BookSearchView> createState() => _BookSearchViewState();
}

class _BookSearchViewState extends State<BookSearchView> {
  final _searchController = TextEditingController();
  final List<Book> _books = [];
  Future<void> _searchBooks() async {
    final query = _searchController.text;
    if (query.isEmpty) {
      return;
    }

    try {
      final results = await SearchService.searchBooks(query);
      setState(() {
        _books.clear();
        _books.addAll(results.map((data) => Book.fromJson(data)));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to search books'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchViewModel>(
      viewModel: SearchViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppStrings.searchFBooks,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: _searchBooks,
                  ),
                ),
                onSubmitted: (_) => _searchBooks(),
                autocorrect: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _books.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = _books[index];
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: _books[index].thumbnailUrl.isNotEmpty
                          ? Image.network(_books[index].thumbnailUrl)
                          : const Icon(
                              Icons.book,
                            ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookDetailView(book: book),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        AppStrings.search,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
