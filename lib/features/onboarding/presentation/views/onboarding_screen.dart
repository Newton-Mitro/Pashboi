import 'package:flutter/material.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/index.dart';
import 'package:pashboi/features/onboarding/data/constants/onboarding_list_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final onboardingItems = OnboardingListItems.getListItems(context);
    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingItems.length,
        onPageChanged:
            (value) => setState(() {
              isLastPage = value == onboardingItems.length - 1;
            }),
        controller: _pageController,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
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
                color: const Color.fromARGB(80, 0, 0, 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      onboardingItems[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onboardingItems[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 50),
                    isLastPage
                        ? getStartedButton(context)
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilledButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: context.theme.colorScheme.secondary,
                                  ),
                                ),
                                backgroundColor:
                                    context.theme.colorScheme.primary,
                                foregroundColor:
                                    context.theme.colorScheme.onPrimary,
                              ),
                              onPressed: () {
                                if ((_pageController.page ?? 0).round() > 0) {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Text(
                                'Previous',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
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
                            FilledButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: context.theme.colorScheme.secondary,
                                  ),
                                ),
                                backgroundColor:
                                    context.theme.colorScheme.primary,
                                foregroundColor:
                                    context.theme.colorScheme.onPrimary,
                              ),
                              onPressed: () {
                                if ((_pageController.page ?? 0).round() <
                                    onboardingItems.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget getStartedButton(BuildContext context) {
  return FilledButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: context.theme.colorScheme.secondary),
      ),
      backgroundColor: context.theme.colorScheme.primary,
      foregroundColor: context.theme.colorScheme.onPrimary,
    ),
    onPressed: () {
      final localStorage = sl<LocalStorage>();
      localStorage.saveBool(Constants.onboardingKey, false);
      Navigator.popAndPushNamed(context, RoutesName.landingPage);
    },
    child: Text(
      'Get Started',
      style: TextStyle(
        fontSize: 14,
        color: context.theme.colorScheme.onPrimary,
      ),
    ),
  );
}
