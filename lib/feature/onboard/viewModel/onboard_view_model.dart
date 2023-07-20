import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/constants/svg_constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../product/models/onboard_model.dart';

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
          title: AppStrings.findEasy,
          description: AppStrings.searchandFind,
          imagePath: SVGConstants.instance.book,
        ),
        OnBoardModel(
          title: AppStrings.addLibrary,
          description: AppStrings.addYourFavorite,
          imagePath: SVGConstants.instance.bookFavorite,
        ),
        OnBoardModel(
          title: AppStrings.readBook,
          description: AppStrings.searchforBooks,
          imagePath: SVGConstants.instance.bookLover,
        ),
      ],
    );
  }
}
