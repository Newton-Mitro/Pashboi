import 'package:flutter/material.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/index.dart';
import 'package:pashboi/core/widgets/my_tool_bar/custom_app_bar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.all(constraints.maxWidth * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppLogo(width: 200, height: 200),
                  Text(
                    context.appLocalizations.welcome,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.06),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        backgroundColor: context.theme.colorScheme.primary,
                        foregroundColor: context.theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.loginPage);
                      },
                      child: Text(context.appLocalizations.login),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        backgroundColor: context.theme.colorScheme.primary,
                        foregroundColor: context.theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.registerPage);
                      },
                      child: Text(context.appLocalizations.register),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        backgroundColor: context.theme.colorScheme.primary,
                        foregroundColor: context.theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.publicHomePage);
                      },
                      child: Text(context.appLocalizations.productAndService),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
