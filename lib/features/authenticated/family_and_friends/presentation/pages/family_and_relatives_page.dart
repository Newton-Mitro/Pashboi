import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/family_and_relatives_bloc/family_and_relatives_bloc.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/app_icon_card.dart';

class FamilyAndRelativesPage extends StatefulWidget {
  const FamilyAndRelativesPage({super.key});

  @override
  State<FamilyAndRelativesPage> createState() => _FamilyAndRelativesPageState();
}

class _FamilyAndRelativesPageState extends State<FamilyAndRelativesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FamilyAndRelativesBloc>().add(FetchFamilyAndRelatives());
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: const Text('Family and Relatives')),
      body: PageContainer(
        child: SafeArea(
          child: BlocBuilder<FamilyAndRelativesBloc, FamilyAndRelativesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final familyList = state.familyAndFriends;

              if (familyList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.boxOpen,
                        size: 60,
                        color: theme.colorScheme.onSurface.withOpacity(0.4),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You don’t have any family or friend added yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                itemCount: familyList.length,
                itemBuilder: (context, index) {
                  final info = familyList[index];
                  final isMale = (info.familyMemberGender).toUpperCase() == 'M';
                  final icon =
                      isMale ? FontAwesomeIcons.mars : FontAwesomeIcons.venus;
                  final requestStatus = info.requestStatus;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: AppIconCard(
                      leftIcon: icon,
                      cardBody: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            info.familyMemberName.toTitleCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            info.relationName,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  requestStatus == "Approved"
                                      ? Colors.green
                                      : Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              requestStatus,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.normal,
                                color:
                                    requestStatus == "Approved"
                                        ? theme.colorScheme.onTertiary
                                        : theme.colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      boarderColor: theme.colorScheme.primary,
                      onTap: () {
                        // You can add detailed page navigation here if needed
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
