import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_home/views/stepper/progress_step_with_chevron.dart';
import 'package:pashboi/features/authenticated_home/views/stepper/progress_stepper.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class FamilyMenusView extends StatefulWidget {
  const FamilyMenusView({super.key});

  @override
  State<FamilyMenusView> createState() => _FamilyMenusViewState();
}

class _FamilyMenusViewState extends State<FamilyMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": Icons.account_balance,
      "menuName": "Family",
      "menuDescription": "Place for all your dependent accounts.",
    },
  ];

  int currentStep = 1;

  final List<IconData> steps = [
    Icons.money,
    Icons.person,
    Icons.ring_volume,
    Icons.traffic,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: infoMenus.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final menu = infoMenus[index];
            return Column(
              children: [
                MenuTile(
                  icon: Icon(
                    menu['icon'],
                    size: 35,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                  menuName: menu['menuName'],
                  menuDescription: menu['menuDescription'],
                  onTap: () {
                    debugPrint("Tapped on ${menu['menuName']}");
                  },
                ),
                const SizedBox(height: 8),
                ProgressStepper(
                  width: 350,
                  height: 50,
                  stepCount: steps.length,
                  bluntHead: false,
                  bluntTail: true,
                  padding: 6,
                  currentStep: currentStep,
                  builder: (
                    BuildContext context,
                    int index,
                    double widthOfStep,
                  ) {
                    return ProgressStepWithChevron(
                      width: widthOfStep,
                      height: 50,
                      defaultColor: context.theme.colorScheme.surface,
                      progressColor: context.theme.colorScheme.primary,
                      borderWidth: 1,
                      borderColor: context.theme.colorScheme.secondary,
                      wasCompleted: index <= currentStep,
                      child: Center(
                        child: Icon(
                          steps[index - 1],
                          color:
                              index <= currentStep
                                  ? context.theme.colorScheme.onPrimary
                                  : context.theme.colorScheme.onSurface,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),

                // Text(currentStep.toString()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppPrimaryButton(
                      label: "Pervious",
                      onPressed: () {
                        setState(() {
                          if (currentStep > 1) currentStep--;
                        });
                      },
                    ),

                    AppPrimaryButton(
                      label: "Next",
                      onPressed: () {
                        setState(() {
                          if (currentStep < 4) currentStep++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
