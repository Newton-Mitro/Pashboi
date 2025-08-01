import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeSelectorEvent>(
      offset: const Offset(0, 52),
      icon: Icon(Icons.color_lens, color: context.theme.colorScheme.onPrimary),
      tooltip: 'Select Theme',
      onSelected: (event) {
        context.read<ThemeSelectorBloc>().add(event);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: SetDarkAbyssTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Dark Abyss'),
                ],
              ),
            ),
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
              value: SetBlueOceanDarkTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Blue Ocean Dark'),
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
              value: SetEleganceDarkTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Elegance Dark'),
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
              value: SetOliverPetalDarkTheme(),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 18,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: 8),
                  Text('Oliver Petal Dark'),
                ],
              ),
            ),
          ],
    );
  }
}
