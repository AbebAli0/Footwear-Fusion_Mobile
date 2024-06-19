import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/auth/pages/sign_in_page.dart';
import 'package:shoes_store/presentation/auth/pages/sign_up_page.dart';
import 'package:shoes_store/presentation/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store/providers/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        home: SplashPage(),
        theme: AppTheme.darkMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
