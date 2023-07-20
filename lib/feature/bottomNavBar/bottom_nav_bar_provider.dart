import 'package:book_app/feature/category/view/category_page_view.dart';
import 'package:book_app/feature/favorite/view/favorite_view.dart';
import 'package:book_app/feature/home/view/book_home_view.dart';
import 'package:book_app/feature/search/view/book_search_view.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'bottom_nav_bar_provider.g.dart';

class BottomNavBarProvider = _BottomNavBarProviderBase with _$BottomNavBarProvider;

abstract class _BottomNavBarProviderBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final pages = [
    const BookHomeView(),
    const BookCategoryView(),
    const FavoriteBooksView(),
    const BookSearchView(),
  ];
}
