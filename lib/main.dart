import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/feature/favorite/provider/favorite_provider.dart';
import 'package:book_app/feature/onboard/view/onboard_view.dart';
import 'package:book_app/feature/search/viewModel/book_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteBooks()),
          ChangeNotifierProvider(create: (_) => BookSearchViewModel()),
          ChangeNotifierProvider(create: (_) => CategoryViewModel()..fetchBookCategories()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book App',
      home: OnboardView(),
    );
  }
}
