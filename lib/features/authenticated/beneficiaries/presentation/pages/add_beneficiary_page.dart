import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/add_beneficiary_bloc/add_beneficiary_bloc.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/presentation/bloc/collection_ledger_bloc.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';

class AddBeneficiaryPage extends StatefulWidget {
  const AddBeneficiaryPage({super.key});

  @override
  State<AddBeneficiaryPage> createState() => _AddBeneficiaryPageState();
}

class _AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  final TextEditingController _accountSearchController =
      TextEditingController();
  final TextEditingController _accountHolderController =
      TextEditingController();

  String _accountNumber = '';

  void _submit() {
    context.read<AddBeneficiaryBloc>().add(
      AddBeneficiarySubmit(
        accountNumber: _accountNumber,
        beneficiaryName: _accountHolderController.text.trim(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _accountSearchController.text = '';
  }

  void _showSnackBar(String title, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = context.theme;

    return MultiBlocListener(
      listeners: [
        BlocListener<AddBeneficiaryBloc, AddBeneficiaryState>(
          listener: (context, state) {
            if (state is AddBeneficiaryFailure) {
              _showSnackBar('Oops!', state.error, ContentType.failure);
            }
            if (state is AddBeneficiarySuccess) {
              _showSnackBar(
                'Success',
                'Beneficiary added successfully',
                ContentType.success,
              );
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
            if (state is AddBeneficiaryValidationError) {
              // Handle validation errors if you want to show a snack or something here
              // Currently errors will show inline in fields below
            }
          },
        ),
        BlocListener<CollectionLedgerBloc, CollectionLedgerState>(
          listener: (context, state) {
            if (state is CollectionLedgerLoaded) {
              final person = state.collectionAggregate.accountHolderInfo;
              final rawInput = _accountSearchController.text.trim();

              // Clean search text to digits only
              final searchText = rawInput.replaceAll(RegExp(r'\D'), '');

              final matchedAccounts =
                  state.collectionAggregate.ledgers
                      .where(
                        (ledger) => ledger.accountNumber.toLowerCase().contains(
                          searchText,
                        ),
                      )
                      .toList();

              if (matchedAccounts.isNotEmpty) {
                final matchedAccount = matchedAccounts.first;
                _accountSearchController.text = matchedAccount.accountNumber;
                setState(() {
                  _accountNumber = matchedAccount.accountNumber;
                });
                _accountHolderController.text = person.name;
              } else {
                _accountSearchController.text = rawInput;
                _accountHolderController.clear();
                _accountNumber = '';
              }
            }

            if (state is CollectionLedgerError) {
              _showSnackBar('Oops!', state.message, ContentType.failure);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(Locales.string(context, 'add_beneficiary_page_title')),
        ),
        body: BlocBuilder<AddBeneficiaryBloc, AddBeneficiaryState>(
          builder: (context, addBeneficiaryState) {
            final validationErrors =
                addBeneficiaryState is AddBeneficiaryValidationError
                    ? addBeneficiaryState.errors
                    : null;

            final isLoading = addBeneficiaryState is AddBeneficiaryLoading;

            return PageContainer(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.users,
                            size: 40,
                            color: theme.colorScheme.onSurface,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Locales.string(
                              context,
                              'add_beneficiary_page_title',
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 45),
                          BlocBuilder<
                            CollectionLedgerBloc,
                            CollectionLedgerState
                          >(
                            builder: (context, collectionState) {
                              return AppSearchTextInput(
                                controller: _accountSearchController,
                                label: Locales.string(
                                  context,
                                  'add_beneficiary_page_account_number_input_label',
                                ),
                                isSearch: true,
                                enabled:
                                    collectionState is! CollectionLedgerLoading,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.piggyBank,
                                  color: theme.colorScheme.onSurface,
                                ),
                                errorText:
                                    collectionState
                                            is CollectionLedgerValidationError
                                        ? collectionState.errors['searchText']
                                        : validationErrors?['accountNumber'],
                                onSearchPressed: () {
                                  final searchText =
                                      _accountSearchController.text.trim();
                                  context.read<CollectionLedgerBloc>().add(
                                    FetchCollectionLedgersEvent(
                                      searchText: searchText,
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
                            label: Locales.string(
                              context,
                              'add_beneficiary_page_account_holder_name',
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: theme.colorScheme.onSurface,
                            ),
                            enabled: false,
                            errorText: validationErrors?['beneficiaryName'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProgressSubmitButton(
                    width: width - 10,
                    height: 100,
                    backgroundColor: theme.colorScheme.primary,
                    progressColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    label: Locales.string(
                      context,
                      'add_beneficiary_page_submit_button_text',
                    ),
                    enabled: !isLoading,
                    onSubmit: isLoading ? null : _submit,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
