import 'package:flutter/material.dart';
import 'package:shoes_store/core/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar();
    }

    return Column(
      children: [
        header(),
      ],
    );
  }
}
