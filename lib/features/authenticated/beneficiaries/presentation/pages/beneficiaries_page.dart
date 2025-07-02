import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/bloc/beneficiary_bloc.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.boxOpen,
            size: 60,
            color: context.theme.colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'You don’t have any family or relative accounts added',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: context.theme.colorScheme.onSurface,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BeneficiaryBloc>()..add(FetchBeneficiaries()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Beneficiaries')),
        body: PageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: BlocBuilder<BeneficiaryBloc, BeneficiaryState>(
                  builder: (context, state) {
                    if (state is BeneficiaryInitial) {
                      context.read<BeneficiaryBloc>().add(FetchBeneficiaries());
                    }

                    if (state is BeneficiaryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BeneficiaryLoaded) {
                      final beneficiaries = state.beneficiaries;
                      if (beneficiaries.isEmpty) {
                        return _buildEmptyState(context);
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: beneficiaries.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final beneficiary = beneficiaries[index];
                          return Dismissible(
                            key: ValueKey(beneficiary.accountNumber),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              context.read<BeneficiaryBloc>().add(
                                DeleteBeneficiary(beneficiary.accountNumber),
                              );
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: InkWell(
                              onTap: () => {},
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.theme.colorScheme.surface,
                                  border: Border.all(
                                    color: context.theme.colorScheme.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .primary,
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft: Radius.circular(
                                                    4,
                                                  ),
                                                ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              FontAwesomeIcons.personCirclePlus,
                                              size: 30,
                                              color:
                                                  context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                beneficiary.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                beneficiary.accountNumber,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: Icon(
                                          Icons.delete_sweep,
                                          color:
                                              context
                                                  .theme
                                                  .colorScheme
                                                  .onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is BeneficiaryError) {
                      return Center(child: Text(state.error));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Click to add a family member or a relative!',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AppPrimaryButton(
                      iconBefore: const Icon(Icons.person_add),
                      horizontalPadding: 6,
                      label: "Add Beneficiary",
                      onPressed: () {
                        context.read<BeneficiaryBloc>().add(
                          CreateBeneficiary(
                            beneficiaryName: "John Doe",
                            accountNumber: "T-9999999999",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
