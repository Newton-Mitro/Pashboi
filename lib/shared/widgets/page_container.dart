import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  const PageContainer({super.key, required this.child});

  String _getBackgroundImage(ThemeSelectorState state) {
    if (state is DarkBlueAbyssTheme) {
      return AppImages.pathPrimaryDarkBgImage;
    } else if (state is OliverPetalTheme) {
      return AppImages.pathForeverGreenLightBgImage;
    } else if (state is EleganceTheme) {
      return AppImages.pathPinkLightBgImage;
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
            SafeArea(child: child),
          ],
        );
      },
    );
  }
}
