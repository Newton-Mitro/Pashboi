import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final isEnglish = state.language == 'en';

        return GestureDetector(
          onTap: () {
            context.read<LanguageBloc>().add(
              LanguageSelected(language: isEnglish ? 'bn' : 'en'),
            );
          },
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color:
                  context
                      .theme
                      .colorScheme
                      .onSurface, // Switch background set to white
              border: Border.all(
                color: context.theme.colorScheme.primary,
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                // Rectangular thumb
                AnimatedAlign(
                  alignment:
                      isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 28,
                    height: 30,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(),
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                ),
                // "ENG" text
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'EN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              isEnglish
                                  ? context.theme.colorScheme.onPrimary
                                  : context.theme.colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ),
                // "বাংলা" text
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'BN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              isEnglish
                                  ? context.theme.colorScheme.onError
                                  : context.theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
