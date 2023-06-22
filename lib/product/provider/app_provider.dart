import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/feature/favorite/viewModel/favorite_view_model.dart';
import 'package:book_app/feature/home/viewModel/home_view_model.dart';
import 'package:book_app/feature/search/viewModel/book_search_view_model.dart';
import 'package:book_app/product/service/book_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> appProviders = [
    ChangeNotifierProvider(create: (_) => FavoriteViewModel()),
    ChangeNotifierProvider(create: (_) => BookSearchViewModel()),
    ChangeNotifierProvider(create: (_) => CategoryViewModel()..fetchBookCategories()),
    ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()..fetchBooks()),
    ChangeNotifierProvider<BookService>(create: (_) => BookService()..fetchBooks()),
  ];
}
