import 'package:flutter/material.dart';
import 'package:shoes_store/core/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Page',
        style: primaryTextStyle,
      ),
    );
  }
}
