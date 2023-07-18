import 'package:book_app/feature/category/viewModel/category_view_model.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/widgets/appbar/custom_appbar.dart';
import 'package:book_app/product/widgets/container/header_container.dart';
import 'package:book_app/product/widgets/indicator/progress_indicator.dart';
import 'package:flutter/material.dart';

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
        return Scaffold(
          appBar: const CustomAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppStrings.categories,
            ),
          ),
          body: viewModel.isLoading
              ? CustomProgressIndicator(text: AppStrings.wait, indicatorColor: AppColors.green)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: context.dynamicHeight(0.05)),
                      CategoryGrid(viewModel: viewModel),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.viewModel,
  });

  final CategoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        final category = viewModel.categories[index];
        return Column(
          children: [
            HeaderContainer(
              onTap: () async {
                viewModel.fetchAndNavigate(index, category);
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
