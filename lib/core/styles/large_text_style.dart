import 'package:flutter/material.dart';

import 'package:pashboi/core/styles/app_text_style.dart';

class LargeTextStyle extends AppTextStyle {
  @override
  TextStyle get appBarTextStyle => TextStyle(fontSize: 16);

  @override
  TextStyle get appBarLogoTextStyle => TextStyle(fontSize: 32);

  @override
  TextStyle get titleTextStyle =>
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  @override
  TextStyle get subTitleTextStyle =>
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  @override
  TextStyle get bodyTextStyle => TextStyle(fontSize: 18);

  @override
  TextStyle get buttonTextStyle =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  TextStyle get captionTextStyle => TextStyle(fontSize: 14);

  @override
  TextStyle get overlineTextStyle => TextStyle(fontSize: 12);
}
