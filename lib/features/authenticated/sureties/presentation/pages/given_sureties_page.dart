import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
import 'package:pashboi/features/authenticated/sureties/presentation/pages/bloc/surety_bloc.dart';
import 'package:pashboi/features/authenticated/sureties/presentation/pages/suerity_details.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class GivenSuretiesPage extends StatelessWidget {
  const GivenSuretiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SuretyBloc>()..add(FetchGivenSuretiesEvent()),
      child: Scaffold(
        body: PageContainer(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16.0),
            height: double.infinity,
            child: BlocBuilder<SuretyBloc, SuretyState>(
              builder: (context, state) {
                if (state is SuretyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SuretyError) {
                  return Center(child: Text(state.error));
                }

                if (state is SuretyLoadingSuccess) {
                  final List<SuretyEntity> sureties = state.sureties;

                  if (sureties.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.boxOpen,
                            size: 60,
                            color: context.theme.colorScheme.onSurface
                                .withOpacity(0.4),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'You don’t have any surety account added yet.',
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

                  return Accordion(
                    headerBorderWidth: 3,
                    headerBorderColor: context.theme.colorScheme.primary,
                    headerBorderColorOpened: context.theme.colorScheme.primary,
                    headerBackgroundColorOpened:
                        context.theme.colorScheme.primary,
                    contentBackgroundColor: context.theme.colorScheme.surface,
                    contentBorderColor: context.theme.colorScheme.primary,
                    contentBorderWidth: 3,
                    contentHorizontalPadding: 20,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    children:
                        sureties.map((surety) {
                          final isDefaulter = surety.defaulter;

                          final headerColor =
                              isDefaulter
                                  ? context.theme.colorScheme.error
                                  : context.theme.colorScheme.primary;

                          final iconColor =
                              isDefaulter
                                  ? context.theme.colorScheme.onError
                                  : context.theme.colorScheme.onPrimary;

                          return AccordionSection(
                            isOpen: false,
                            headerBackgroundColor: headerColor,
                            headerBackgroundColorOpened: headerColor,
                            headerBorderColor: headerColor,
                            contentBorderColor: headerColor,
                            contentVerticalPadding: 20,
                            paddingBetweenClosedSections: 20,
                            leftIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                isDefaulter
                                    ? FontAwesomeIcons.personCircleXmark
                                    : FontAwesomeIcons.personCircleCheck,
                                size: 30,
                                color: iconColor,
                              ),
                            ),
                            header: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  surety.loanNumber,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: iconColor,
                                  ),
                                ),
                                Text(
                                  surety.accountHolderName.toTitleCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: iconColor,
                                  ),
                                ),
                              ],
                            ),
                            content: SuerityDetails(surety: surety),
                          );
                        }).toList(),
                  );
                }

                return const SizedBox.shrink(); // fallback
              },
            ),
          ),
        ),
      ),
    );
  }
}
