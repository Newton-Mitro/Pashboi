import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/service/domain/enities/service_policy_entity.dart';
import 'package:pashboi/features/public/service/presentation/bloc/service_policy_bloc.dart';
import 'package:pashboi/features/public/service/presentation/bloc/service_policy_state.dart';
import 'package:pashboi/features/public/service/presentation/service_policy_details_page.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => sl<ServicePolicyBloc>()..add(FetchServicePolicyEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Services'),
          backgroundColor: context.theme.colorScheme.primary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          elevation: 0,
        ),
        body: PageContainer(
          child: BlocBuilder<ServicePolicyBloc, ServicePolicyState>(
            builder: (context, state) {
              if (state is ServiceProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ServicePolicySuccess) {
                final List<ServicePolicyEntity> policies =
                    state.servicePolicies;

                if (policies.isEmpty) {
                  return const Center(
                    child: Text("No service policies available."),
                  );
                }

                return ListView.builder(
                  itemCount: policies.length,
                  itemBuilder: (context, index) {
                    final policy = policies[index];
                    return Card(
                      elevation: 1,
                      shadowColor: const Color.fromARGB(179, 0, 0, 0),
                      surfaceTintColor: context.theme.colorScheme.primary,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(policy.attachmentUrl),
                          radius: 20,
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(policy.title),
                        subtitle: Text(
                          policy.shortDescription ?? 'No description',
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ServicePolicyDetailsPage(service: policy),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (state is ServicePolicyError) {
                return Center(child: Text("Error: ${state.error}"));
              }

              return const SizedBox.shrink(); // Initial or unknown state
            },
          ),
        ),
      ),
    );
  }
}
