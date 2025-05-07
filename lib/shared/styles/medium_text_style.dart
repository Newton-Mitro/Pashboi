import 'package:flutter/material.dart';

import 'package:pashboi/shared/styles/app_text_style.dart';

class MediumTextStyle extends AppTextStyle {
  @override
  TextStyle get appBarTextStyle => TextStyle(fontSize: 14);

  @override
  TextStyle get appBarLogoTextStyle => TextStyle(fontSize: 26);

  @override
  TextStyle get titleTextStyle =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  TextStyle get subTitleTextStyle =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  TextStyle get bodyTextStyle => TextStyle(fontSize: 16);

  @override
  TextStyle get buttonTextStyle =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  TextStyle get captionTextStyle => TextStyle(fontSize: 13);

  @override
  TextStyle get overlineTextStyle => TextStyle(fontSize: 11);
}
