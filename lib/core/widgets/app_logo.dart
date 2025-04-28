import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/core/widgets/theme_switcher/bloc/theme_bloc.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({super.key, this.width = 30, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Image.asset(
          state is LightThemeState ? AppImages.logo : AppImages.logoDark,
          width: width,
          height: height,
        );
      },
    );
  }
}
