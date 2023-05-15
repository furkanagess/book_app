import 'package:book_app/product/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'category_list_view_model.g.dart';

class CategoryListViewModel = _CategoryListViewModelBase with _$CategoryListViewModel;

abstract class _CategoryListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
}
