import 'package:flutter/material.dart';
import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/auth/pages/sign_in_page.dart';
import 'package:shoes_store/presentation/auth/pages/sign_up_page.dart';
import 'package:shoes_store/presentation/splash/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      theme: AppTheme.darkMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
