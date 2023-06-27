import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/routes/app_routes.dart';
import 'package:book_app/product/widgets/container/header_container.dart';
import 'package:book_app/product/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCategoryView extends StatelessWidget {
  const BookCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryViewModel>(
      viewModel: CategoryViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, CategoryViewModel viewModel) {
        final categoryViewModel = Provider.of<CategoryViewModel>(context);
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: buildAppbar(context),
          body: categoryViewModel.isLoading
              ? CustomProgressIndicator(text: AppStrings.wait, indicatorColor: AppColors.green)
              : SafeArea(
                  child: ListView(
                    children: [
                      SizedBox(height: context.dynamicHeight(0.05)),
                      CategoryGrid(categoryModel: categoryViewModel),
                    ],
                  ),
                ),
        );
      },
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        AppStrings.categories,
        style: context.textTheme.headlineSmall?.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.categoryModel,
  });

  final CategoryViewModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoryModel.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        final category = categoryModel.categories[index];
        return Column(
          children: [
            HeaderContainer(
              onTap: () async {
                AppRoutes().navigateToCategory(context, category);
                final bookModel = Provider.of<CategoryViewModel>(context, listen: false);
                await bookModel.fetchBooksByCategory(category.name);
              },
              bgColor: AppColors.green,
              textColor: AppColors.white,
              text: category.name,
            ),
          ],
        );
      },
    );
  }
}
