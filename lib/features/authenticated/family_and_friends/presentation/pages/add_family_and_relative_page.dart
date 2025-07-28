import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/presentation/bloc/collection_ledger_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/family_and_friends_bloc/family_and_friends_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/relationship_bloc/relationship_bloc.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';

class AddFamilyAndRelativesPage extends StatefulWidget {
  const AddFamilyAndRelativesPage({super.key});

  @override
  State<AddFamilyAndRelativesPage> createState() =>
      _AddFamilyAndRelativesPageState();
}

class _AddFamilyAndRelativesPageState extends State<AddFamilyAndRelativesPage> {
  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _accountSearchController =
      TextEditingController();

  String? selectedRelationship;
  String? gender;

  @override
  void dispose() {
    _accountHolderController.dispose();
    _accountSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Family or Relative')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CollectionLedgerBloc, CollectionLedgerState>(
            listener: (context, state) {
              if (state is CollectionLedgerLoaded) {
                final person = state.collectionAggregate.accountHolderInfo;
                _accountHolderController.text = person.name ?? '';
                gender = person.gender;

                if (gender != null && gender!.isNotEmpty) {
                  context.read<RelationshipBloc>().add(
                    FetchRelationshipsEvent(gender: gender!),
                  );
                }
              } else if (state is CollectionLedgerError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<RelationshipBloc, RelationshipState>(
            listener: (context, state) {
              if (state is RelationshipError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<FamilyAndFriendsBloc, FamilyAndFriendsState>(
            listener: (context, state) {
              if (state.error != null && state.error!.isNotEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              }

              // Assuming your FamilyAndFriendsState has a way to indicate success;
              // if you have a boolean or specific state, use that:
              if (!state.isLoading && state.error == null) {
                // Could improve this by checking an explicit success event or flag
                // For now, just pop if not loading and no error after add
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        child: PageContainer(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.users,
                        size: 40,
                        color: theme.colorScheme.onSurface,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Add Family or Relative",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 36),
                      BlocBuilder<CollectionLedgerBloc, CollectionLedgerState>(
                        builder: (context, state) {
                          return AppSearchTextInput(
                            controller: _accountSearchController,
                            label: "Account Number",
                            isSearch: true,
                            enabled: state is! CollectionLedgerLoading,
                            prefixIcon: Icon(
                              FontAwesomeIcons.piggyBank,
                              color: theme.colorScheme.onSurface,
                            ),
                            errorText:
                                state is CollectionLedgerValidationError
                                    ? state.errors['searchText']
                                    : null,
                            onSearchPressed: () {
                              context.read<CollectionLedgerBloc>().add(
                                FetchCollectionLedgersEvent(
                                  searchText:
                                      _accountSearchController.text.trim(),
                                  moduleCode: '16',
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextInput(
                        controller: _accountHolderController,
                        label: "Member Name",
                        enabled: false,
                        prefixIcon: Icon(
                          Icons.person,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<RelationshipBloc, RelationshipState>(
                        builder: (context, state) {
                          if (state is RelationshipLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is RelationshipLoaded) {
                            return AppDropdownSelect<String>(
                              value: selectedRelationship,
                              label: "Relationship",
                              errorText: '',
                              // state is FamilyAndFriendValidationError
                              //     ? state.errors['relationTypeCode']
                              //     : null,
                              items:
                                  state.relationships
                                      .map(
                                        (rel) => DropdownMenuItem(
                                          value: rel.code,
                                          child: Text(rel.name),
                                        ),
                                      )
                                      .toList(),

                              onChanged: (value) {
                                setState(() {
                                  selectedRelationship = value;
                                });
                              },
                              prefixIcon: FontAwesomeIcons.usersViewfinder,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ProgressSubmitButton(
                width: MediaQuery.of(context).size.width - 30,
                height: 100,
                backgroundColor: theme.colorScheme.primary,
                progressColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onPrimary,
                label: 'Hold & Press to Submit',
                onSubmit: () {
                  if (!mounted) return;

                  // if (selectedRelationship == null ||
                  //     _accountHolderController.text.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text("Please fill all fields")),
                  //   );
                  //   return;
                  // }

                  final state = context.read<CollectionLedgerBloc>().state;
                  if (state is CollectionLedgerLoaded) {
                    final personId =
                        state.collectionAggregate.accountHolderInfo.id ?? 0;

                    context.read<FamilyAndFriendsBloc>().add(
                      AddFamilyAndFriend(
                        childPersonId: personId,
                        relationTypeCode: selectedRelationship!,
                        accountNumber: _accountSearchController.text.trim(),
                        memberName: _accountHolderController.text.trim(),
                        gender: gender!,
                        relationship: selectedRelationship!,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Account info not loaded")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
