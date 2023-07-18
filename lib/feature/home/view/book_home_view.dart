import 'package:book_app/feature/home/viewModel/home_view_model.dart';

import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/constants/svg_constants.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/routes/app_routes.dart';
import 'package:book_app/product/widgets/appbar/custom_appbar.dart';
import 'package:book_app/product/widgets/container/book_info_container.dart';
import 'package:book_app/product/widgets/indicator/progress_indicator.dart';
import 'package:book_app/product/widgets/text/row_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookHomeView extends StatefulWidget {
  const BookHomeView({super.key});

  @override
  State<BookHomeView> createState() => _BookHomeViewState();
}

class _BookHomeViewState extends State<BookHomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) {
        return Scaffold(
          appBar: const CustomAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppStrings.discover,
            ),
          ),
          body: viewModel.isLoading
              ? CustomProgressIndicator(text: AppStrings.wait, indicatorColor: AppColors.green)
              : SingleChildScrollView(
                  child: Padding(
                    padding: context.paddingLowHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerInfoContainer(context),
                        SizedBox(height: context.dynamicHeight(0.05)),
                        pageHeaders(context, AppStrings.trending, AppStrings.seeMore),
                        trendBooksListview(context, viewModel),
                        SizedBox(height: context.dynamicHeight(0.05)),
                        pageHeaders(context, AppStrings.bestseller, AppStrings.seeMore),
                        bestsellerBooksListview(context, viewModel),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  SizedBox bestsellerBooksListview(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: context.dynamicHeight(0.45),
      child: ListView.builder(
        itemCount: viewModel.bestsellerBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final bestsellerBook = viewModel.bestsellerBooks[index];
          return BookInfoContainer(
            onTap: () {
              AppRoutes().navigateToDetail(context, bestsellerBook);
            },
            img: bestsellerBook.thumbnailUrl.isEmpty
                ? Icon(
                    Icons.book,
                    size: 150,
                    color: AppColors.green,
                  )
                : Image.network(
                    bestsellerBook.thumbnailUrl,
                    fit: BoxFit.fill,
                    width: context.dynamicWidth(0.4),
                    height: context.dynamicHeight(0.22),
                  ),
            bgColor: AppColors.darkWhite,
            title: bestsellerBook.title,
            subColor: AppColors.darkGrey,
            subText: bestsellerBook.author,
            titleColor: AppColors.white,
          );
        },
      ),
    );
  }

  SizedBox trendBooksListview(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: context.dynamicHeight(0.45),
      child: ListView.builder(
        itemCount: viewModel.trendingBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final trendBook = viewModel.trendingBooks[index];
          return BookInfoContainer(
            onTap: () {
              AppRoutes().navigateToDetail(context, trendBook);
            },
            img: trendBook.thumbnailUrl.isEmpty
                ? Icon(
                    Icons.book,
                    size: 150,
                    color: AppColors.green,
                  )
                : Image.network(
                    trendBook.thumbnailUrl,
                    fit: BoxFit.fill,
                    width: context.dynamicWidth(0.4),
                    height: context.dynamicHeight(0.22),
                  ),
            bgColor: AppColors.darkWhite,
            title: trendBook.title,
            subColor: AppColors.darkGrey,
            subText: trendBook.author,
            titleColor: AppColors.white,
          );
        },
      ),
    );
  }

  Container headerInfoContainer(BuildContext context) {
    return Container(
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(0.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkWhite,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconTextRow(
                    icon: Icons.bookmark,
                    iconColor: AppColors.green,
                    text: AppStrings.findEasy,
                    textColor: AppColors.white,
                  ),
                  IconTextRow(
                    icon: Icons.bookmark,
                    iconColor: AppColors.green,
                    text: AppStrings.readBook,
                    textColor: AppColors.white,
                  ),
                  IconTextRow(
                    icon: Icons.bookmark,
                    iconColor: AppColors.green,
                    text: AppStrings.addLibrary,
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                height: context.dynamicHeight(0.1),
                SVGConstants.instance.bookLover,
              ),
            )
          ],
        ));
  }

  Row pageHeaders(BuildContext context, String header, String? actions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.white,
          ),
        ),
        Text(
          actions!,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
