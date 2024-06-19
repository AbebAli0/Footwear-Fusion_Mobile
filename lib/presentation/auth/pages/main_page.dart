import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/auth/pages/cart_page.dart';
import 'package:shoes_store/presentation/auth/pages/chat_page.dart';
import 'package:shoes_store/presentation/auth/pages/home_page.dart';
import 'package:shoes_store/presentation/auth/pages/wishlist_page.dart';
import 'package:shoes_store/presentation/auth/pages/profile_page.dart';

import 'package:shoes_store/presentation/routes/app_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  String token = "";
  String email = "";
  String username = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? "";
      email = prefs.getString('email') ?? "";
      username = prefs.getString('username') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context, Routes.cart());
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: backgroundColor4,
            currentIndex: currentIndex,
            onTap: (value) {
              print(value);
              setState(() {
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    right: 1,
                  ),
                  child: Image.asset(
                    'assets/icon_home.png',
                    width: 21,
                    color: currentIndex == 0 ? primaryColor : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: Container(
              //     margin: EdgeInsets.only(
              //       right: 40,
              //     ),
              //     child: Image.asset(
              //       'assets/icon_chat.png',
              //       width: 20,
              //       color: currentIndex == 1 ? primaryColor : Color(0xff808191),
              //     ),
              //   ),
              //   label: '',
              // ),
              // BottomNavigationBarItem(
              //   icon: Container(
              //     margin: EdgeInsets.only(
              //       left: 40,
              //     ),
              //     child: Image.asset(
              //       'assets/icon_wishlist.png',
              //       width: 20,
              //       color: currentIndex == 2 ? primaryColor : Color(0xff808191),
              //     ),
              //   ),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    right: 1,
                  ),
                  child: Image.asset(
                    'assets/icon_profile.png',
                    width: 18,
                    color: currentIndex == 3 ? primaryColor : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      return Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                HomePage(
                    key: UniqueKey(),
                    username: username), // Menghapus kata kunci const
                // ChatPage(key: UniqueKey()), // Menghapus kata kunci const
                // WishlistPage(key: UniqueKey()), // Menghapus kata kunci const
                ProfilePage(
                    key: UniqueKey(),
                    username: username), // Menghapus kata kunci const
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: currentIndex == 0 ? backgroundColor1 : backgroundColor3,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: SafeArea(
        child: body(),
      ),
    );
  }
}
