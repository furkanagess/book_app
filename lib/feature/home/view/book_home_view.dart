import 'package:book_app/feature/home/viewModel/home_view_model.dart';

import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/constants/svg_constants.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/feature/detail/view/book_detail_view.dart';
import 'package:book_app/product/models/book.dart';
import 'package:book_app/product/service/book_service.dart';
import 'package:book_app/product/widgets/container/book_info_container.dart';
import 'package:book_app/product/widgets/text/row_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
      onPageBuilder: (BuildContext context, HomeViewModel homeViewModel) {
        final bookService = Provider.of<BookService>(context);
        final trendingBooks = bookService.trendingBooks;
        final bestsellerBooks = bookService.bestsellerBooks;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: context.paddingLowHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerInfoContainer(context),
                  SizedBox(height: context.dynamicHeight(0.05)),
                  trendingsHeaderRow(context),
                  TrendingListview(trendingBooks: trendingBooks),
                  SizedBox(height: context.dynamicHeight(0.05)),
                  recommendedHeaderRow(context),
                  BestsellerListview(bestsellerBooks: bestsellerBooks),
                ],
              ),
            ),
          ),
        );
      },
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
                height: 100,
                SVGConstants.instance.bookLover,
              ),
            )
          ],
        ));
  }

  Row recommendedHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.bestseller,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.white,
          ),
        ),
        Text(
          AppStrings.seeMore,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Row trendingsHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.trending,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.white,
          ),
        ),
        Text(
          AppStrings.seeMore,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Row headerRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.homeHeader,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppStrings.discover,
        style: context.textTheme.headlineSmall?.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }
}

class BestsellerListview extends StatelessWidget {
  const BestsellerListview({
    super.key,
    required this.bestsellerBooks,
  });

  final List<Book> bestsellerBooks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: ListView.builder(
        itemCount: bestsellerBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final bestsellerBook = bestsellerBooks[index];
          return BookInfoContainer(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailView(book: bestsellerBook),
              ),
            ),
            img: bestsellerBook.thumbnailUrl == ""
                ? Icon(
                    Icons.book,
                    size: 150,
                    color: AppColors.green,
                  )
                : Image.network(
                    bestsellerBook.thumbnailUrl,
                    fit: BoxFit.fill,
                    height: 200,
                    width: 200,
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
}

class TrendingListview extends StatelessWidget {
  const TrendingListview({
    super.key,
    required this.trendingBooks,
  });

  final List<Book> trendingBooks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: ListView.builder(
        itemCount: trendingBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final trendBook = trendingBooks[index];
          return BookInfoContainer(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailView(book: trendBook),
              ),
            ),
            img: trendBook.thumbnailUrl == ""
                ? Icon(
                    Icons.book,
                    size: 150,
                    color: AppColors.green,
                  )
                : Image.network(
                    trendBook.thumbnailUrl,
                    fit: BoxFit.fill,
                    height: 200,
                    width: 200,
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
}
