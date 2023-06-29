// ignore_for_file: library_private_types_in_public_api

import 'package:book_app/product/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'book_detail_view_model.g.dart';

class BookDetailViewModel = _BookDetailViewModelBase with _$BookDetailViewModel;

abstract class _BookDetailViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}

  void favoriteSnackbar() {}
}
