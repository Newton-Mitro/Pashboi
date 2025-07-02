import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/get_family_and_friends_bloc/family_and_friends_bloc.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/widgets/app_icon_card.dart';

class FamilyAndRelativesPage extends StatelessWidget {
  const FamilyAndRelativesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocProvider(
      create:
          (context) => sl<FamilyAndFriendsBloc>()..add(LoadFamilyAndFriends()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Family and Relatives')),
        body: PageContainer(
          child: SafeArea(
            child: BlocBuilder<FamilyAndFriendsBloc, FamilyAndFriendsState>(
              builder: (context, state) {
                final theme = context.theme;

                if (state is FamilyAndFriendsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is FamilyAndFriendsLoadingSuccess) {
                  final familyList = state.familyAndFriends;

                  if (familyList.isEmpty) {
                    return Center(
                      child: Text(
                        'You don’t have any family or relative accounts added',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                        ),
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
                      final isMale =
                          info.familyMemberGender.toUpperCase() == 'M';
                      final icon =
                          isMale
                              ? FontAwesomeIcons.mars
                              : FontAwesomeIcons.venus;
                      final requestStatus = info.requestStatus;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: AppIconCard(
                          showRightIcon: false,
                          leftIcon: icon,
                          cardBody: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info.familyMemberName,
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
                          onTap: () {},
                        ),
                      );
                    },
                  );
                }

                if (state is FamilyAndFriendsError) {
                  return Center(child: Text(state.error));
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Click to add a family member or a relative!',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              AppPrimaryButton(
                iconBefore: const Icon(Icons.person_add),
                label: "Add Family or Relative",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AuthRoutesName.addFamilyMemberPage,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
