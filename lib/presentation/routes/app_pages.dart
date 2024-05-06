import 'package:flutter/material.dart';

import '../auth/pages/sign_in_page.dart';
import '../auth/pages/sign_up_page.dart';

class Routes {
  static login() => MaterialPageRoute(builder: (context) => const SignInPage());
  static register() => MaterialPageRoute(builder: (context) => const SignUpPage());
}
