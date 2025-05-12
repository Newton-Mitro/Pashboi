import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  String _getBackgroundImage(ThemeSelectorState state) {
    if (state is PrimaryDarkThemeState) {
      return AppImages.pathPrimaryDarkBgImage;
    } else if (state is ForeverGreenLightThemeState) {
      return AppImages.pathForeverGreenLightBgImage;
    } else {
      return AppImages.pathPrimaryLightBgImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSelectorBloc, ThemeSelectorState>(
      builder: (context, state) {
        final backgroundImage = _getBackgroundImage(state);

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(backgroundImage, fit: BoxFit.cover),
            ),
            child,
          ],
        );
      },
    );
  }
}
