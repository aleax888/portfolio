import 'package:flutter/material.dart';
import 'package:portfolio/design_system/themes/app_theme.dart';
import 'package:portfolio/pages/portfolio_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: PortfolioPage(),
    );
  }
}
