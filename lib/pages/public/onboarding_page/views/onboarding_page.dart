import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/core/widgets/language_selector/language_selector.dart';
import 'package:pashboi/core/widgets/theme_switcher/theme_switcher.dart';
import 'package:pashboi/pages/public/onboarding_page/data/constants/onboarding_list_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final onboardingItems = OnboardingListItems.getListItems(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: onboardingItems.length,
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
                isLastPage = value == onboardingItems.length - 1;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    onboardingItems[index].imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color.fromARGB(169, 1, 0, 5),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 80,
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          onboardingItems[index].title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          onboardingItems[index].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(child: LanguageSelector()),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(child: ThemeSwitcher()),
          ),

          /// Bottom Buttons Outside PageView
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Show "Previous" only if not on first page
                  if (currentPage > 0)
                    FilledButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text(
                        Locales.string(context, 'onboarding_previous_button'),
                        style: TextStyle(
                          fontSize: 12,
                          color: context.theme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 88), // reserve space
                  // Smooth Page Indicator in the center
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: onboardingItems.length,
                    effect: ExpandingDotsEffect(
                      dotColor: context.theme.colorScheme.primary,
                      activeDotColor: context.theme.colorScheme.error,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),

                  // Right button (Next or Get Started)
                  isLastPage
                      ? getStartedButton(context)
                      : FilledButton(
                        onPressed: () {
                          if (currentPage < onboardingItems.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        child: Text(
                          Locales.string(context, 'onboarding_next_button'),
                          style: TextStyle(
                            fontSize: 12,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getStartedButton(BuildContext context) {
  return FilledButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: context.theme.colorScheme.secondary),
      ),
      backgroundColor: context.theme.colorScheme.primary,
      foregroundColor: context.theme.colorScheme.onPrimary,
    ),
    onPressed: () {
      final localStorage = sl<LocalStorage>();
      localStorage.saveBool(Constants.keyOnboarding, false);
      Navigator.popAndPushNamed(context, RoutesName.landingPage);
    },
    child: Text(
      Locales.string(context, 'onboarding_get_started_button'),
      style: TextStyle(
        fontSize: 12,
        color: context.theme.colorScheme.onPrimary,
      ),
    ),
  );
}
