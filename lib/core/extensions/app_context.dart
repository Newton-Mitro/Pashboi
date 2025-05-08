import 'package:flutter/material.dart';

import 'package:pashboi/core/theme/styles/app_text_style.dart';
import 'package:pashboi/core/theme/styles/large_text_style.dart';
import 'package:pashboi/core/theme/styles/medium_text_style.dart';
import 'package:pashboi/core/theme/styles/small_text_style.dart';

import 'package:pashboi/core/theme/values/dimensions/app_dimensions.dart';
import 'package:pashboi/core/theme/values/dimensions/large_app_dimensions.dart';
import 'package:pashboi/core/theme/values/dimensions/medium_app_dimensions.dart';
import 'package:pashboi/core/theme/values/dimensions/small_app_dimensions.dart';

enum DeviceType { mobile, tablet, desktop }

extension AppContext on BuildContext {
  DeviceType get deviceType {
    final double width = MediaQuery.of(this).size.width;
    if (width < 600) {
      return DeviceType.mobile;
    } else if (width < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  AppTextStyle get textStyle {
    switch (deviceType) {
      case DeviceType.mobile:
        return SmallTextStyle();
      case DeviceType.tablet:
        return MediumTextStyle();
      case DeviceType.desktop:
        return LargeTextStyle();
    }
  }

  AppDimensions get appDimensions {
    switch (deviceType) {
      case DeviceType.mobile:
        return SmallAppDimensions();
      case DeviceType.tablet:
        return MediumAppDimensions();
      case DeviceType.desktop:
        return LargeAppDimensions();
    }
  }

  ThemeData get theme => Theme.of(this);
}
