// ignore_for_file: library_private_types_in_public_api

import 'package:book_app/feature/main/main_page.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/constants/svg_constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../model/onboard_model.dart';

part 'onboard_view_model.g.dart';

class OnboardViewModel = _OnboardViewModelBase with _$OnboardViewModel;

abstract class _OnboardViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @observable
  int currentIndex = 0;

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }

  List<OnBoardModel> onBoardPages = [];
  @override
  void init() {
    onBoardPages.addAll(
      [
        OnBoardModel(
          title: "Find Easily",
          description: "Search and find the books that appeal to you the most among thousands of books",
          imagePath: SVGConstants.instance.book,
        ),
        OnBoardModel(
          title: "Add to Library",
          description: "Add your favorite books to your library with one click to find them easier another time",
          imagePath: SVGConstants.instance.bookFavorite,
        ),
        OnBoardModel(
          title: "Read Book",
          description: "You can search for books and categories at any time, read more with the library",
          imagePath: SVGConstants.instance.bookLover,
        ),
      ],
    );
  }

  void completeToOnBoard() {
    Navigator.push(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
  }
}
