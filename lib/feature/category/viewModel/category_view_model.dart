import 'package:book_app/feature/category/service/category_service.dart';
import 'package:book_app/product/base/base_view_model.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/models/book_category.dart';
import 'package:book_app/product/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
part 'category_view_model.g.dart';

class CategoryViewModel = _CategoryViewModelBase with _$CategoryViewModel;

abstract class _CategoryViewModelBase with Store, BaseViewModel, ChangeNotifier {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  void init() {}
  List<Book> books = [];
  List<BookCategory> categories = [];
  bool isLoading = false;
  final CategoryService _categoryService = CategoryService();
  late final CategoryViewModel categoryModel;

  Future<void> fetchBookCategories() async {
    isLoading = true;
    notifyListeners();
    categories = await _categoryService.fetchBookCategories();
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByCategory(String category) async {
    isLoading = true;
    notifyListeners();
    books = await _categoryService.fetchBooksByCategory(category);
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAndNavigate(index, BookCategory category) async {
    AppRoutes().navigateToCategory(context as BuildContext, category);
    final bookModel = Provider.of<CategoryViewModel>(context as BuildContext, listen: false);
    await bookModel.fetchBooksByCategory(categories[index].name);
  }
}
