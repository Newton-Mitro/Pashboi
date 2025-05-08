import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeEvent>(
      icon: Icon(Icons.color_lens, color: context.theme.colorScheme.onSurface),
      tooltip: 'Select Theme',
      onSelected: (event) {
        context.read<ThemeBloc>().add(event);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: SetPrimaryLightTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Primary Light'),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetPrimaryDarkTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Primary Dark'),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetForeverGreenLightTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Forever Green'),
                ],
              ),
            ),
          ],
    );
  }
}
