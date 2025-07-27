import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/authenticated_home/bloc/authenticated_home_bloc.dart';

class AuthenticatedBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems;

  const AuthenticatedBottomSheet({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return BlocBuilder<AuthenticatedHomeBloc, AuthenticatedHomeState>(
      builder: (context, state) {
        final int currentIndex =
            state is PageChangedState ? state.selectedPage : -1;

        final Color activeIconColor = context.theme.colorScheme.onPrimary;
        final Color activeBgColor = context.theme.colorScheme.primary;
        final Color inactiveIconColor = context.theme.colorScheme.onSurface
            .withAlpha(180);
        final Color inactiveBgColor = context.theme.colorScheme.surface;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: context.theme.colorScheme.secondary,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Top handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Scrollable icon grid
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  thickness: 1,
                  radius: const Radius.circular(8),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children:
                          menuItems.skip(4).map((item) {
                            final int index = item['index'] as int;
                            final bool isActive = index == currentIndex;

                            return GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                context.read<AuthenticatedHomeBloc>().add(
                                  ChangePageEvent(index),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color:
                                          isActive
                                              ? activeBgColor
                                              : inactiveBgColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border:
                                          isActive
                                              ? Border.all(
                                                color:
                                                    context
                                                        .theme
                                                        .colorScheme
                                                        .primary,
                                                width: 2,
                                              )
                                              : null,
                                    ),
                                    child: Icon(
                                      item['icon'] as IconData,
                                      color:
                                          isActive
                                              ? activeIconColor
                                              : inactiveIconColor,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['label'] as String,
                                    style: context.theme.textTheme.bodySmall
                                        ?.copyWith(
                                          color:
                                              isActive
                                                  ? context
                                                      .theme
                                                      .colorScheme
                                                      .onSurface
                                                  : context
                                                      .theme
                                                      .colorScheme
                                                      .onSurface
                                                      .withAlpha(360),
                                          fontWeight:
                                              isActive
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 70),
            ],
          ),
        );
      },
    );
  }
}
