import 'package:book_app/feature/category/view/category_page_view.dart';
import 'package:book_app/feature/favorite/view/favorite.dart';
import 'package:book_app/feature/home/view/book_home_view.dart';
import 'package:book_app/feature/search/view/book_search_view.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  final pages = [
    BookHomeView(),
    BookSearchView(),
    FavoriteBooksView(),
    BookCategoriesView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amberAccent,
        currentIndex: currentPage,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            backgroundColor: Colors.amberAccent,
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            backgroundColor: Colors.amberAccent,
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_add,
            ),
            backgroundColor: Colors.amberAccent,
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            backgroundColor: Colors.amberAccent,
            label: "Category",
          ),
        ],
      ),
    );
  }
}
