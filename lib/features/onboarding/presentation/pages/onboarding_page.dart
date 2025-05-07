import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/language_selector/language_selector.dart';
import 'package:pashboi/shared/widgets/theme_switcher/theme_switcher.dart';
import 'package:pashboi/features/onboarding/data/constants/onboarding_list_items.dart';
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
                    AppPrimaryButton(
                      label: Locales.string(
                        context,
                        'onboarding_previous_button',
                      ),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      iconBefore: Icon(
                        Icons.arrow_back,
                        color: context.theme.colorScheme.onPrimary,
                      ),
                      horizontalPadding: 0,
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
                      ? AppPrimaryButton(
                        label: Locales.string(
                          context,
                          'onboarding_get_started_button',
                        ),
                        onPressed: () {
                          final localStorage = sl<LocalStorage>();
                          localStorage.saveBool(
                            StorageKey.keyOnboarding,
                            false,
                          );
                          Navigator.popAndPushNamed(
                            context,
                            PublicRoutesName.landingPage,
                          );
                        },
                        iconAfter: Icon(
                          Icons.rocket_launch,
                          color: context.theme.colorScheme.onPrimary,
                        ),
                        horizontalPadding: 0,
                      )
                      : AppPrimaryButton(
                        label: Locales.string(
                          context,
                          'onboarding_next_button',
                        ),
                        onPressed: () {
                          if (currentPage < onboardingItems.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        iconAfter: Icon(
                          Icons.arrow_forward,
                          color: context.theme.colorScheme.onPrimary,
                        ),
                        horizontalPadding: 0,
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
