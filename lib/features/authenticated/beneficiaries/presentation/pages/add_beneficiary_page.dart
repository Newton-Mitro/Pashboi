import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/bloc/beneficiary_bloc.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/presentation/bloc/collection_ledger_bloc.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  late String _accountNumber;

  bool _isValidInput() {
    return _accountSearchController.text.trim().isNotEmpty &&
        _accountHolderController.text.trim().isNotEmpty;
  }

  void _submit() {
    if (!_isValidInput()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter all fields")));
      return;
    }

    context.read<BeneficiaryBloc>().add(
      CreateBeneficiary(
        accountNumber: _accountNumber,
        beneficiaryName: _accountHolderController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MultiBlocListener(
      listeners: [
        BlocListener<BeneficiaryBloc, BeneficiaryState>(
          listener: (context, state) {
            if (state.error != null) {
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Oops!',
                  message: state.error!,
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            } else if (!state.isLoading && state.error == null) {
              // Assuming successful add returns to previous page
              Navigator.of(context).pop();
            }
          },
        ),
        BlocListener<CollectionLedgerBloc, CollectionLedgerState>(
          listener: (context, state) {
            if (state is CollectionLedgerLoaded) {
              final person = state.collectionAggregate.accountHolderInfo;
              final rawInput = _accountSearchController.text.trim();
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
              }
            }

            if (state is CollectionLedgerError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Beneficiary')),
        body: PageContainer(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.users,
                    size: 40,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Add Beneficiary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 45),
                  BlocBuilder<CollectionLedgerBloc, CollectionLedgerState>(
                    builder: (context, state) {
                      return AppSearchTextInput(
                        controller: _accountSearchController,
                        label: "Account Number",
                        isSearch: true,
                        enabled: state is! CollectionLedgerLoading,
                        prefixIcon: Icon(
                          FontAwesomeIcons.piggyBank,
                          color: context.theme.colorScheme.onSurface,
                        ),
                        onSearchPressed: () {
                          final searchText =
                              _accountSearchController.text.trim();

                          if (searchText.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter account number"),
                              ),
                            );
                            return;
                          }

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
                    label: "Account Holder Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    enabled: false,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(5),
          child: ProgressSubmitButton(
            width: width - 10,
            height: 100,
            backgroundColor: context.theme.colorScheme.primary,
            progressColor: context.theme.colorScheme.secondary,
            foregroundColor: context.theme.colorScheme.onPrimary,
            label: 'Hold & Press to Submit',
            onSubmit: _submit,
          ),
        ),
      ),
    );
  }
}
