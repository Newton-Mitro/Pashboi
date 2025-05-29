import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class AppLogo extends StatefulWidget {
  final double width;
  const AppLogo({super.key, this.width = 25});

  @override
  State<AppLogo> createState() => AppLogoState();
}

class AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSelectorBloc, ThemeSelectorState>(
      builder: (context, state) {
        return Column(
          children: [
            Image.asset(
              state is DarkBlueAbyssTheme || state is DarkBlueOceanTheme
                  ? AppImages.pathLogoDark
                  : AppImages.pathLogo,
              width: widget.width,
            ),
            Text(
              Locales.string(context, 'organization_name'),
              style: TextStyle(
                fontSize: 18,
                color: context.theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
