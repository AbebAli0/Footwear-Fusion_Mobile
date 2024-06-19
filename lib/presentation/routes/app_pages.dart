import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/auth/pages/cart_page.dart';
import 'package:shoes_store/presentation/auth/pages/checkout_page.dart';
import 'package:shoes_store/presentation/auth/pages/checkout_success_page.dart';
import 'package:shoes_store/presentation/auth/pages/product_page.dart';
import 'package:shoes_store/presentation/auth/pages/profile_page.dart';

import '../auth/pages/sign_in_page.dart';
import '../auth/pages/sign_up_page.dart';
import '../auth/pages/main_page.dart';
import '../auth/pages/detail_chat_page.dart';
import '../auth/pages/edit_profile_page.dart';
import '../auth/pages/chat_page.dart';
import '../auth/pages/cart_page.dart';

class Routes {
  static login() => MaterialPageRoute(builder: (context) => const SignInPage());
  static register() =>
      MaterialPageRoute(builder: (context) => const SignUpPage());
  static main() => MaterialPageRoute(builder: (context) => const MainPage());
  static chat() =>
      MaterialPageRoute(builder: (context) => const DetailChatPage());
  static edit() => MaterialPageRoute(builder: (context) => EditProfilePage());
  static profile(String username) =>
      MaterialPageRoute(builder: (context) => ProfilePage(username: username));
  // static product(String id_product) => MaterialPageRoute(builder: (context) => ProductPage(id_product: id_product));
  static cart() => MaterialPageRoute(builder: (context) => CartPage());
  static checkout() => MaterialPageRoute(builder: (context) => CheckoutPage());
  static checkoutsuccess() =>
      MaterialPageRoute(builder: (context) => CheckoutSuccessPage());
}
