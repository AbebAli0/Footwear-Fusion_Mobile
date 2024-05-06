import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class HeaderAuthField extends StatelessWidget {
  const HeaderAuthField({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: primaryTextStyle.copyWith(
        fontSize: 16,
        fontWeight: medium,
      ),
    );
  }
}
