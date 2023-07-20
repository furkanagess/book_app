import 'package:book_app/feature/bottomNavBar/bottom_nav_bar_provider.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavBarProvider>(
      viewModel: BottomNavBarProvider(),
      onPageBuilder: (context, BottomNavBarProvider provider) {
        return Scaffold(
          body: provider.pages[provider.currentIndex],
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
            currentIndex: provider.currentIndex,
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              provider.setCurrentIndex(index);
            },
            items: [
              navbarItem(Icons.home, AppStrings.homeLabel),
              navbarItem(Icons.book, AppStrings.categoriesLabel),
              navbarItem(Icons.favorite, AppStrings.favoritesLabel),
              navbarItem(Icons.search, AppStrings.searcLabel),
            ],
          ),
        );
      },
      onModelReady: (model) {
        model.setContext(context);
      },
    );
  }

  BottomNavigationBarItem navbarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: label,
    );
  }
}
