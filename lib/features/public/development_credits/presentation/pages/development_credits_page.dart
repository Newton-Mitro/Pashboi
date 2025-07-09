import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';
import 'package:pashboi/features/public/development_credits/presentation/bloc/development_credit_bloc.dart';
import 'package:pashboi/features/public/development_credits/presentation/pages/development_creadit_details.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class DevelopmentCreditsPage extends StatelessWidget {
  const DevelopmentCreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<DevelopmentCreditBloc>()..add(FetchDevelopmentCreditEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Development Credit')),
        body: PageContainer(
          child: BlocBuilder<DevelopmentCreditBloc, DevelopmentCreditState>(
            builder: (context, state) {
              if (state is DevelopmentCreditLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DevelopmentCreditSuccess) {
                final List<DevelopmentCreditsEntity> pages =
                    state.developmentCredit;

                if (pages.isEmpty) {
                  return const Center(child: Text("No pages available."));
                }

                return ListView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Card(
                      elevation: 1,
                      shadowColor: const Color.fromARGB(179, 0, 0, 0),
                      surfaceTintColor: context.theme.colorScheme.surface,
                      color: context.theme.colorScheme.surface,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(page.attachmentUrl),
                          radius: 20,
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          page.name,
                          style: TextStyle(
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          page.designation ?? 'No description',
                          style: TextStyle(
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DevelopmentCreditDetails(credit: page),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (state is DevelopmentCreditError) {
                return Center(child: Text('Error: ${state.error}'));
              }

              return const SizedBox.shrink(); // For initial/unknown state
            },
          ),
        ),
      ),
    );
  }
}
