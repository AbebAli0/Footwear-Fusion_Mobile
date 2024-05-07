import 'package:flutter/material.dart';

import '../auth/pages/sign_in_page.dart';
import '../auth/pages/sign_up_page.dart';
import '../auth/pages/main_page.dart';

class Routes {
  static login() => MaterialPageRoute(builder: (context) => const SignInPage());
  static register() =>
      MaterialPageRoute(builder: (context) => const SignUpPage());
  static main() => MaterialPageRoute(builder: (context) => const MainPage());
}
