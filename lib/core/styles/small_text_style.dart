import 'package:flutter/material.dart';

import 'package:pashboi/core/styles/app_text_style.dart';

class SmallTextStyle extends AppTextStyle {
  @override
  TextStyle get appBarTextStyle => TextStyle(fontSize: 12);

  @override
  TextStyle get appBarLogoTextStyle => TextStyle(fontSize: 24);

  @override
  TextStyle get titleTextStyle =>
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  @override
  TextStyle get subTitleTextStyle =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  TextStyle get bodyTextStyle => TextStyle(fontSize: 14);

  @override
  TextStyle get buttonTextStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  TextStyle get captionTextStyle => TextStyle(fontSize: 12);

  @override
  TextStyle get overlineTextStyle => TextStyle(fontSize: 10);
}
