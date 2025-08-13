import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/presentation/bloc/collection_ledger_bloc.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class BankTransferInfoSection extends StatefulWidget {
  final String? sectionTitle;
  final void Function(List<CollectionLedgerEntity> collectionLedgers)
  setCollectionLedgers;
  final String? searchedAccountHolderName;
  final void Function(String? accountNumber) changeSearchAccountNumber;
  final void Function(String? accountNumber) onChangeSearchAccountNumber;
  final void Function(String? beneficiaryAccountNumber)
  changeBeneficiaryAccountNumber;
  final void Function(String? accountHolderName)
  changeSearchedAccountHolderName;

  const BankTransferInfoSection({
    super.key,
    required this.searchedAccountHolderName,
    required this.sectionTitle,
    required this.setCollectionLedgers,
    required this.changeSearchAccountNumber,
    required this.onChangeSearchAccountNumber,
    required this.changeBeneficiaryAccountNumber,
    required this.changeSearchedAccountHolderName,
  });

  @override
  State<BankTransferInfoSection> createState() =>
      _BankTransferInfoSectionState();
}

class _BankTransferInfoSectionState extends State<BankTransferInfoSection> {
  String? selectedBankId;
  String? bankAccountNumber;
  String? routingNumber;
  String? transactionId;
  double? transferAmount;
  String? remarks;
  File? selectedImage;

  final _imagePicker = ImagePicker();

  void _pickImage() async {
    final result = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        selectedImage = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionLedgerBloc, CollectionLedgerState>(
      listener: (context, state) {
        if (state is CollectionLedgerError) {
          widget.changeSearchedAccountHolderName("");
        }
        if (state is CollectionLedgerLoaded) {
          final ledgers = state.collectionAggregate.ledgers;
          widget.setCollectionLedgers(ledgers);

          final searchText = ''; // Replace with actual input
          final onlyDigits = searchText.replaceAll(RegExp(r'\D'), '');

          try {
            final matchedLedger = ledgers.firstWhere(
              (ledger) => ledger.accountNumber.trim().contains(onlyDigits),
            );
            widget.changeSearchAccountNumber(
              matchedLedger.accountNumber.trim(),
            );
            widget.changeSearchedAccountHolderName(
              state.collectionAggregate.accountHolderInfo.name
                  .trim()
                  .toTitleCase(),
            );
          } catch (_) {}
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, widget.sectionTitle ?? "Bank Transfer Info"),
          _buildFormBody(context),
        ],
      ),
    );
  }

  Widget _buildFormBody(BuildContext context) {
    final theme = context.theme;

    // Mock bank list (replace with real data from state/BLoC if needed)
    final bankList = [
      {'id': '1', 'name': 'AB Bank'},
      {'id': '2', 'name': 'BRAC Bank'},
      {'id': '3', 'name': 'Dutch-Bangla Bank'},
    ];

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.primary),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
      ),
      child: Scrollbar(
        thumbVisibility: true, // Always show the scrollbar
        radius: const Radius.circular(8), // Rounded edges for modern look
        thickness: 6, // Customize thickness
        trackVisibility: true,
        interactive: true, // Makes the scrollbar draggable
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bank dropdown
              AppDropdownSelect(
                label: "Select Bank",
                value: selectedBankId,
                prefixIcon: FontAwesomeIcons.buildingColumns,
                items:
                    bankList
                        .map(
                          (bank) => DropdownMenuItem(
                            value: bank['id'],
                            child: Text(bank['name']!),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setState(() => selectedBankId = val),
              ),
              const SizedBox(height: 16),

              // Bank Account Number
              AppTextInput(
                enabled: false,
                label: "Bank Account Number",
                prefixIcon: const Icon(Icons.account_balance),
                onChanged: (val) => bankAccountNumber = val,
              ),
              const SizedBox(height: 16),

              // Routing Number
              AppTextInput(
                enabled: false,
                label: "Routing Number",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.route),
                onChanged: (val) => routingNumber = val,
              ),
              const SizedBox(height: 16),

              // Transaction ID
              AppTextInput(
                label: "Transaction ID",
                prefixIcon: const Icon(Icons.confirmation_number),
                onChanged: (val) => transactionId = val,
              ),
              const SizedBox(height: 16),

              // Amount
              AppTextInput(
                label: "Amount",
                prefixIcon: const Icon(Icons.attach_money),
                keyboardType: TextInputType.number,
                onChanged: (val) => transferAmount = double.tryParse(val),
              ),
              const SizedBox(height: 16),

              Text("Attach Bank Transfer Receipt"),
              const SizedBox(height: 5),

              // Receipt Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: DottedBorder(
                  key: const ValueKey("dotted_border_key"),
                  options: RectDottedBorderOptions(
                    color: theme.colorScheme.primary,
                    dashPattern: [8, 4],
                  ),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child:
                        selectedImage != null
                            ? Image.file(selectedImage!)
                            : const Text("Tap to upload receipt image"),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Remarks
              AppTextInput(
                label: "Remarks",
                prefixIcon: const Icon(Icons.edit_note),
                onChanged: (val) => remarks = val,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    final theme = context.theme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
