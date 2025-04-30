import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/language_selector/bloc/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final isEnglish = state.language == 'en';

        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          onPressed: () {
            context.read<LanguageBloc>().add(
              LanguageSelected(language: isEnglish ? 'bn' : 'en'),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flag.fromCode(
                isEnglish ? FlagsCode.US : FlagsCode.BD,
                width: 24,
                height: 16,
              ),
              const SizedBox(width: 8),
              Text(
                isEnglish ? 'en' : 'bn',
                style: TextStyle(
                  fontSize: 16,
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
