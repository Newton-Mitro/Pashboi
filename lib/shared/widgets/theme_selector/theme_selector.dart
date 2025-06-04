import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeSelectorEvent>(
      icon: Icon(Icons.color_lens, color: context.theme.colorScheme.onPrimary),
      tooltip: 'Select Theme',
      onSelected: (event) {
        context.read<ThemeSelectorBloc>().add(event);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: SetBlueOceanTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Blue Ocean'),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetEleganceTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Elegance'),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetDarkBlueAbyssTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Dark Blue Abyss'),
                ],
              ),
            ),
            PopupMenuItem(
              value: SetOliverPetalTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Oliver Petal'),
                ],
              ),
            ),

            PopupMenuItem(
              value: SetDarkBlueOceanTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Dark Blue Ocean'),
                ],
              ),
            ),
          ],
    );
  }
}
