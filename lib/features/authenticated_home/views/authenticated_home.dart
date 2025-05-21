import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:pashboi/features/authenticated_home/bloc/authenticated_home_bloc.dart';
import 'package:pashboi/features/authenticated_home/views/menus/accounts_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/beneficiary_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/deposit_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/family_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/info_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/loans_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/payment_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/personnel_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/transfer_menus_view.dart';
import 'package:pashboi/features/authenticated_home/views/menus/withdraw_menus_view.dart';
import 'package:pashboi/features/authenticated_home/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/app_dialog.dart';

final List<Widget> menuViews = [
  InfoMenusView(),
  AccountsMenusView(),
  LoansMenusView(),
  DepositMenusView(),
  TransferMenusView(),
  WithdrawMenusView(),
  PaymentMenusView(),
  FamilyMenusView(),
  BeneficiaryMenusView(),
  PersonnelMenusView(),
];

class AuthenticatedHome extends StatefulWidget {
  const AuthenticatedHome({super.key});

  @override
  State<AuthenticatedHome> createState() => _AuthenticatedHomeState();
}

class _AuthenticatedHomeState extends State<AuthenticatedHome> {
  int _previousPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": FontAwesomeIcons.circleUser,
        "label": Locales.string(context, 'auth_bottom_nav_menu_info'),
      },
      {
        "icon": FontAwesomeIcons.buildingColumns,
        "label": Locales.string(context, 'auth_bottom_nav_menu_accounts'),
      },
      {
        "icon": FontAwesomeIcons.fileInvoiceDollar,
        "label": Locales.string(context, 'auth_bottom_nav_menu_loan'),
      },
      {
        "icon": FontAwesomeIcons.piggyBank,
        "label": Locales.string(context, 'auth_bottom_nav_menu_deposit'),
      },
      {
        "icon": FontAwesomeIcons.rightLeft,
        "label": Locales.string(context, 'auth_bottom_nav_menu_transfer'),
      },
      {
        "icon": FontAwesomeIcons.moneyBill,
        "label": Locales.string(context, 'auth_bottom_nav_menu_withdraw'),
      },
      {
        "icon": FontAwesomeIcons.wallet,
        "label": Locales.string(context, 'auth_bottom_nav_menu_payment'),
      },
      {
        "icon": FontAwesomeIcons.peopleRoof,
        "label": Locales.string(context, 'auth_bottom_nav_menu_family'),
      },
      {
        "icon": FontAwesomeIcons.userGroup,
        "label": Locales.string(context, 'auth_bottom_nav_menu_beneficiary'),
      },
      {
        "icon": FontAwesomeIcons.idBadge,
        "label": Locales.string(context, 'auth_bottom_nav_menu_personnel'),
      },
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthenticatedHomeBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is UnAuthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              PublicRoutesName.landingPage,
              (route) => false,
            );

            // Navigator.popAndPushNamed(context, PublicRoutesName.root);
            // Navigator.pushReplacementNamed(context, PublicRoutesName.root);
          }
        },
        child: BlocBuilder<AuthenticatedHomeBloc, AuthenticatedHomeState>(
          builder: (context, authHomeState) {
            int selectedPage = 0;
            if (authHomeState is PageChangedState) {
              selectedPage = authHomeState.selectedPage;
            } else if (authHomeState is AuthenticatedHomeInitial) {
              selectedPage = authHomeState.selectedPage;
            }

            final isForward = selectedPage >= _previousPage;
            _previousPage = selectedPage;

            return PopScope(
              canPop: false,
              onPopInvoked: (didPop) async {
                if (!didPop) {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => AppDialog(
                          title: 'Logout',
                          content: 'Are you sure you want to logout?',
                          icon: const Icon(Icons.logout, size: 40),
                          onPositiveButtonTap:
                              () => context.read<AuthBloc>().add(
                                LogoutRequested(),
                              ),
                          positiveButtonLabel: 'Logout',
                        ),
                  );
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(menuItems[selectedPage]['label']),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  elevation: 4,
                  actions: [
                    PopupMenuButton<int>(
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) async {
                        if (value == 0) {
                          debugPrint('Profile tapped');
                        } else if (value == 1) {
                          debugPrint('Settings tapped');
                        } else if (value == 2) {
                          await showDialog(
                            context: context,
                            builder:
                                (_) => AppDialog(
                                  title: 'Logout',
                                  content: 'Are you sure you want to logout?',
                                  icon: const Icon(Icons.logout, size: 40),
                                  onPositiveButtonTap:
                                      () => context.read<AuthBloc>().add(
                                        LogoutRequested(),
                                      ),
                                  positiveButtonLabel: 'Logout',
                                ),
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                            const PopupMenuItem(
                              value: 0,
                              child: Row(
                                children: [
                                  Icon(Icons.person, size: 20),
                                  SizedBox(width: 8),
                                  Text('Profile'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.settings, size: 20),
                                  SizedBox(width: 8),
                                  Text('Settings'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              enabled: false,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.2,
                                height: 8,
                              ),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.logout, size: 20),
                                  SizedBox(width: 8),
                                  Text('Logout'),
                                ],
                              ),
                            ),
                          ],
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg',
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                body: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final offsetTween = Tween<Offset>(
                      begin:
                          isForward ? const Offset(1, 0) : const Offset(-1, 0),
                      end: Offset.zero,
                    );
                    return SlideTransition(
                      position: offsetTween.animate(animation),
                      child: child,
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey<int>(selectedPage),
                    child: AppBackground(child: menuViews[selectedPage]),
                  ),
                ),
                bottomNavigationBar: CustomBottomNav(
                  selectedIndex: selectedPage,
                  onTap: (index) {
                    context.read<AuthenticatedHomeBloc>().add(
                      ChangePageEvent(index),
                    );
                  },
                  menuItems: menuItems,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
