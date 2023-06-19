import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_app/feature/main/main_page.dart';
import 'package:book_app/product/base/base_view.dart';
import 'package:book_app/product/constants/app_colors.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/extensions/context_extension.dart';
import 'package:book_app/product/widgets/avatar/onboad_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/onboard_model.dart';
import '../viewModel/onboard_view_model.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardViewModel>(
      viewModel: OnboardViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, OnboardViewModel viewModel) => Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 7,
                child: buildPageView(viewModel),
              ),
              Expanded(
                flex: 2,
                child: buildRowFooter(viewModel, context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView(OnboardViewModel viewModel) {
    return PageView.builder(
      onPageChanged: (value) {
        viewModel.changeCurrentIndex(value);
      },
      itemCount: viewModel.onBoardPages.length,
      itemBuilder: (context, index) {
        return buildColumnBody(
          context,
          viewModel.onBoardPages[index],
        );
      },
    );
  }

  Row buildRowFooter(OnboardViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: buildCircle(viewModel),
        ),
        buildSkipButton(context, viewModel)
      ],
    );
  }

  ListView buildCircle(OnboardViewModel viewModel) {
    return ListView.builder(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Observer(
          builder: (_) {
            return OnBoardCircle(isSelected: viewModel.currentIndex == index);
          },
        );
      },
    );
  }

  FloatingActionButton buildSkipButton(BuildContext context, OnboardViewModel viewModel) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColors.green,
      child: Text(
        AppStrings.skip,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
      },
    );
  }

  Column buildColumnBody(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Padding(
            padding: context.paddingNormalHorizontal,
            child: buildSVGPicture(model.imagePath),
          ),
        ),
        buildColumnDescription(context, model),
      ],
    );
  }

  Padding buildColumnDescription(BuildContext context, OnBoardModel model) {
    return Padding(
      padding: context.paddingMediumHorizontal,
      child: Column(
        children: [
          AutoSizeText(
            textAlign: TextAlign.center,
            maxLines: 2,
            model.title,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: context.height * 0.03),
          AutoSizeText(
            textAlign: TextAlign.center,
            maxLines: 4,
            model.description,
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }

  SvgPicture buildSVGPicture(String path) => SvgPicture.asset(path);
}
