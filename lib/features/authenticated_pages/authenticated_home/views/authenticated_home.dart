import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/bloc/authenticated_home_bloc.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/accounts_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/beneficiary_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/deposit_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/family_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/info_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/loans_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/payment_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/personnel_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/transfer_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/menus/withdraw_menus_view.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/widgets/authenticated_home_drawer.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/widgets/base64_image_widget.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/app_dialog.dart';
import 'package:pashboi/shared/widgets/language_switch/language_switch.dart';
import 'package:pashboi/shared/widgets/theme_selector/theme_selector.dart';

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
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUserCheck());
  }

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
              (_) => false,
            );
          }
        },
        child: BlocBuilder<AuthenticatedHomeBloc, AuthenticatedHomeState>(
          builder: (context, authHomeState) {
            int selectedPage =
                authHomeState is PageChangedState
                    ? authHomeState.selectedPage
                    : (authHomeState is AuthenticatedHomeInitial
                        ? authHomeState.selectedPage
                        : 0);

            final isForward = selectedPage >= _previousPage;
            _previousPage = selectedPage;

            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (!didPop) {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => AppDialog(
                          title: 'Logout',
                          content: 'Are you sure you want to logout?',
                          icon: const Icon(Icons.logout, size: 40),
                          onPositiveButtonTap: () {
                            Navigator.of(context).pop(); // Close the dialog
                            context.read<AuthBloc>().add(LogoutRequested());
                          },
                          positiveButtonLabel: 'Logout',
                        ),
                  );
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  var user =
                      authState is Authenticated
                          ? authState.authUser.user
                          : null;

                  return Scaffold(
                    drawer: AuthenticatedHomeDrawer(
                      menuItems: menuItems,
                      user: user,
                    ),
                    appBar: AppBar(
                      title: Text(menuItems[selectedPage]['label']),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      elevation: 4,
                      actions: [
                        const ThemeSelector(),
                        const LanguageSwitch(),
                        const SizedBox(width: 10),
                        PopupMenuButton<int>(
                          offset: const Offset(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onSelected: (value) async {
                            if (value == 0) {
                              Navigator.pushNamed(
                                context,
                                AuthRoutesName.familyAndRelativesPage,
                              );
                            } else if (value == 1) {
                              debugPrint('Change password tapped');
                            } else if (value == 2) {
                              await showDialog(
                                context: context,
                                builder:
                                    (_) => AppDialog(
                                      title: 'Logout',
                                      content:
                                          'Are you sure you want to logout?',
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
                                      Icon(Icons.lock_open_rounded, size: 20),
                                      SizedBox(width: 8),
                                      Text('Change Password'),
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: context.theme.colorScheme.onPrimary,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image:
                                      user != null && user.userPicture != null
                                          ? Base64ImageWidget(
                                            base64String: user.userPicture!,
                                          ).imageProvider
                                          : const NetworkImage(
                                            'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg',
                                          ),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                              isForward
                                  ? const Offset(1, 0)
                                  : const Offset(-1, 0),
                          end: Offset.zero,
                        );
                        return SlideTransition(
                          position: offsetTween.animate(animation),
                          child: child,
                        );
                      },
                      child: KeyedSubtree(
                        key: ValueKey<int>(selectedPage),
                        child: PageContainer(child: menuViews[selectedPage]),
                      ),
                    ),
                    bottomNavigationBar: CustomBottomNav(
                      selectedIndex: selectedPage,
                      onTap:
                          (index) => context.read<AuthenticatedHomeBloc>().add(
                            ChangePageEvent(index),
                          ),
                      menuItems: menuItems,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
