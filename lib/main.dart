import 'dart:developer';

import 'package:book_app/feature/home/view/book_home_view.dart';
import 'package:book_app/feature/search/view/book_search_view.dart';
import 'package:book_app/sample/changeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteBooks()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: BookHomeView(),
    );
  }
}
