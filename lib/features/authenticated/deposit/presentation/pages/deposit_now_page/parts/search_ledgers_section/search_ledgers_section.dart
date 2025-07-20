import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/bloc/beneficiary_bloc.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/presentation/bloc/collection_ledger_bloc.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchLedgersSection extends StatefulWidget {
  final String? sectionTitle;
  final String? searchAccountNumber;
  final String? searchAccountNumberError;
  final String? searchedAccountHolderNameError;
  final String? beneficiaryAccountNumber;
  final void Function(List<CollectionLedgerEntity> collectionLedgers)
  setCollectionLedgers;
  final String? searchedAccountHolderName;
  final void Function(String? accountNumber) changeSearchAccountNumber;
  final void Function(String? accountNumber) onChangeSearchAccountNumber;
  final void Function(String? beneficiaryAccountNumber)
  changeBeneficiaryAccountNumber;
  final void Function(String? accountHolderName)
  changeSearchedAccountHolderName;

  const SearchLedgersSection({
    super.key,
    required this.searchAccountNumber,
    required this.searchedAccountHolderName,
    required this.searchAccountNumberError,
    required this.searchedAccountHolderNameError,
    required this.beneficiaryAccountNumber,
    required this.sectionTitle,
    required this.setCollectionLedgers,
    required this.changeSearchAccountNumber,
    required this.onChangeSearchAccountNumber,
    required this.changeBeneficiaryAccountNumber,
    required this.changeSearchedAccountHolderName,
  });

  @override
  State<SearchLedgersSection> createState() => _SearchLedgersSectionState();
}

class _SearchLedgersSectionState extends State<SearchLedgersSection> {
  void _searchWithAccountNumber(String searchText) {
    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter account number")),
      );
      return;
    }

    context.read<CollectionLedgerBloc>().add(
      FetchCollectionLedgersEvent(searchText: searchText, moduleCode: '16'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionLedgerBloc, CollectionLedgerState>(
      listener: (context, state) {
        if (state is CollectionLedgerError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          widget.changeSearchedAccountHolderName("");
        }
        if (state is CollectionLedgerLoaded) {
          final ledgers = state.collectionAggregate.ledgers;
          widget.setCollectionLedgers(ledgers);

          final searchText = widget.searchAccountNumber;
          final onlyDigits = searchText?.replaceAll(RegExp(r'\D'), '');

          try {
            final matchedLedger = ledgers.firstWhere((ledger) {
              return ledger.accountNumber.trim().contains(onlyDigits ?? '');
            });

            widget.changeSearchAccountNumber(
              matchedLedger.accountNumber.trim(),
            );
            widget.changeSearchedAccountHolderName(
              state.collectionAggregate.accountHolderInfo.name
                  .trim()
                  .toTitleCase(),
            );
          } catch (_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Account not found")));
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNomineeSelectionCard(context),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildNomineeSelectionCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        border: Border.all(color: context.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, widget.sectionTitle ?? "Search Account"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BlocBuilder<BeneficiaryBloc, BeneficiaryState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.error != null) {
                      return Center(child: Text(state.error!));
                    }

                    final beneficiaries = state.beneficiaries;

                    if (beneficiaries.isEmpty) {
                      return SizedBox.shrink();
                    } else {
                      return AppDropdownSelect(
                        value: widget.beneficiaryAccountNumber,

                        items:
                            beneficiaries
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.accountNumber,
                                    child: Text(e.name.toTitleCase()),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          widget.changeSearchAccountNumber(value);
                          widget.changeBeneficiaryAccountNumber(value);

                          _searchWithAccountNumber(value ?? '');
                        },
                        label: "Beneficiary",
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text("or"),
                const SizedBox(height: 10),
                BlocBuilder<CollectionLedgerBloc, CollectionLedgerState>(
                  builder: (context, state) {
                    return AppSearchTextInput(
                      initialValue: widget.searchAccountNumber,
                      label: "Account Number",
                      isSearch: true,
                      errorText: widget.searchAccountNumberError,
                      enabled: state is! CollectionLedgerLoading,
                      prefixIcon: Icon(
                        FontAwesomeIcons.piggyBank,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      onChanged: widget.onChangeSearchAccountNumber,
                      onSearchPressed: () {
                        _searchWithAccountNumber(
                          widget.searchAccountNumber ?? '',
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  initialValue: widget.searchedAccountHolderName,
                  label: "Account Holder Name",
                  errorText: widget.searchedAccountHolderNameError,
                  prefixIcon: Icon(
                    Icons.person,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  enabled: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: context.theme.colorScheme.onPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
