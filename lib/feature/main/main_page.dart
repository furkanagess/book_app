import 'package:book_app/feature/category/view/category_page_view.dart';
import 'package:book_app/feature/favorite/view/favorite_view.dart';
import 'package:book_app/feature/home/view/book_home_view.dart';
import 'package:book_app/feature/search/view/book_search_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  final pages = [
    const BookHomeView(),
    const BookCategoryView(),
    const FavoriteBooksView(),
    const BookSearchView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.darkGrey,
        unselectedLabelStyle: TextStyle(
          color: AppColors.darkWhite,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.darkGrey,
        ),
        selectedIconTheme: IconThemeData(
          color: AppColors.green,
          size: 30,
        ),
        currentIndex: currentPage,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: AppStrings.homeLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            label: AppStrings.categoriesLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: AppStrings.favoritesLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: AppStrings.searcLabel,
          ),
        ],
      ),
    );
  }
}
