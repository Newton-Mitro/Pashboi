import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/add_operating_account_page/bloc/add_operating_account_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/dependents_page/bloc/fetch_dependents_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/my_account_page/bloc/my_account_bloc.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddOperatingAccountPage extends StatefulWidget {
  const AddOperatingAccountPage({super.key});

  @override
  State<AddOperatingAccountPage> createState() =>
      _AddOperatingAccountPageState();
}

class _AddOperatingAccountPageState extends State<AddOperatingAccountPage> {
  final TextEditingController _mobileNumberController = TextEditingController();
  int? selectedDependentId;
  String? selectedAccount;

  @override
  void initState() {
    super.initState();
    context.read<FetchDependentsBloc>().add(FetchDependentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Operating Account')),
      body: BlocBuilder<FetchDependentsBloc, FetchDependentsState>(
        builder: (context, state) {
          if (state is FetchDependentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchDependentsError) {
            return Center(child: Text(state.message));
          } else if (state is FetchDependentsLoaded) {
            final dependents = state.dependents;

            return PageContainer(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.users,
                            size: 40,
                            color: context.theme.colorScheme.onSurface,
                          ),
                          const SizedBox(height: 4),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add Operating Account",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 45),
                          AppDropdownSelect<int>(
                            value: selectedDependentId,
                            label: "Dependents",
                            items:
                                dependents
                                    .map(
                                      (dependent) => DropdownMenuItem(
                                        value: dependent.accountHolderId,
                                        child: Text(
                                          dependent.accountHolderName,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<MyAccountBloc>().add(
                                  FetchMyAccountEvent(value),
                                );
                                setState(() {
                                  selectedDependentId = value;
                                  selectedAccount =
                                      null; // Reset account on dependent change
                                });
                              }
                            },
                            prefixIcon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<MyAccountBloc, MyAccountState>(
                            builder: (context, state) {
                              if (state is MyAccountLoading) {
                                return const CircularProgressIndicator();
                              } else if (state is MyAccountError) {
                                return Text(state.error);
                              } else if (state is MyAccountSuccess) {
                                final List<DepositAccountEntity> accounts =
                                    state.myAccounts;
                                return AppDropdownSelect<String>(
                                  value: selectedAccount,
                                  label: "Dependent Accounts",
                                  items:
                                      accounts
                                          .map(
                                            (account) => DropdownMenuItem(
                                              value: account.number,
                                              child: Text(account.number),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAccount = value;
                                      final selectedAcc =
                                          accounts
                                              .where(
                                                (acc) => acc.number == value,
                                              )
                                              .toList();
                                      _mobileNumberController.text =
                                          selectedAcc.isNotEmpty
                                              ? selectedAcc.first.mobileNumber
                                                  .trim()
                                              : '';
                                    });
                                  },
                                  prefixIcon:
                                      Icons.account_balance_wallet_outlined,
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextInput(
                            controller: _mobileNumberController,
                            label: "Mobile Number",
                            enabled: false,
                            prefixIcon: Icon(
                              FontAwesomeIcons.mobile,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProgressSubmitButton(
                    width: width - 30,
                    height: 100,
                    backgroundColor: context.theme.colorScheme.primary,
                    progressColor: context.theme.colorScheme.secondary,
                    foregroundColor: context.theme.colorScheme.onPrimary,
                    label: 'Hold & Press to Submit',
                    onSubmit: () {
                      if (selectedDependentId == null ||
                          selectedAccount == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select all required fields'),
                          ),
                        );
                        return;
                      }

                      context.read<AddOperatingAccountBloc>().add(
                        AddOperatingAccountEvent(
                          accountHolderId: selectedDependentId!,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
