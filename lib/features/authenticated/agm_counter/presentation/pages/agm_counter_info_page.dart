import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/entities/agm_counter_entity.dart';
import 'package:pashboi/features/authenticated/agm_counter/presentation/pages/bloc/agm_counter_bloc.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class AgmCounterInfoPage extends StatefulWidget {
  const AgmCounterInfoPage({super.key});

  @override
  State<AgmCounterInfoPage> createState() => _AgmCounterInfoPageState();
}

class _AgmCounterInfoPageState extends State<AgmCounterInfoPage> {
  final TextEditingController _accountNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AgmCounterBloc>().add(FetchAgmCounterInfoEvent(accountNo: ""));
  }

  @override
  void dispose() {
    _accountNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AGM Counter Info")),
      body: PageContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 🔍 Account No Input
              AppTextInput(
                label: "Account No/Membership No",
                controller: _accountNoController,
              ),
              const SizedBox(height: 12),

              // 🚀 Fetch Button
              ElevatedButton(
                onPressed: () {
                  final accountNo = _accountNoController.text.trim();
                  if (accountNo.isNotEmpty) {
                    context.read<AgmCounterBloc>().add(
                      FetchAgmCounterInfoEvent(accountNo: accountNo),
                    );
                  }
                },
                child: const Text("Find Info"),
              ),
              const SizedBox(height: 24),

              // 🖼 Bloc State Rendering
              BlocBuilder<AgmCounterBloc, AgmCounterState>(
                builder: (context, state) {
                  if (state is AgmCounterInfoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AgmCounterInfoError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is AgmCounterInfoLoaded) {
                    return _buildCounterList(state.agmCounterInfo);
                  }
                  return const Center(
                    child: Text("Enter an account number to fetch info"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget to render AGM Counter List
  Widget _buildCounterList(AGMCounterEntity counter) {
    // Extract digits from counterNo
    String digits = counter.counterNo.replaceAll(RegExp(r'[^0-9]'), '');

    return Card(
      color: context.theme.colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle with digits
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                digits,
                style: TextStyle(
                  color: context.theme.colorScheme.onSecondary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    counter.fullName.toTitleCase().trim(),
                    style: TextStyle(
                      color: context.theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "SlNo: ${counter.slNo}",
                    style: TextStyle(
                      color: context.theme.colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Location: ${counter.locationName}\nAccount No: ${counter.accountNo}",
                    style: TextStyle(
                      fontSize: 14,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
