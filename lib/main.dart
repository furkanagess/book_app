import 'package:book_app/feature/onboard/view/onboard_view.dart';
import 'package:book_app/product/constants/app_strings.dart';
import 'package:book_app/product/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ...ApplicationProvider.instance.appProviders,
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: OnboardView(),
    );
  }
}
