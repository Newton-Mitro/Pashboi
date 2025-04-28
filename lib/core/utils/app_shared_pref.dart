// import 'dart:convert';

// import 'package:pashboi/core/injection.dart';
// import 'package:pashboi/features/home/presentation/notifier/notifiers.dart';
// import 'package:pashboi/features/user/data/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppSharedPref {
//   static final SharedPreferences sharedPref = sl<SharedPreferences>();

//   // Language
//   static Future<void> setAppLocale(String locale) async {
//     sharedPref.setString(localeKey, locale);
//   }

//   static Future<String> getAppLocale() async {
//     return sharedPref.getString(localeKey) ?? 'en';
//   }

//   // Theme
//   static Future<void> setAppTheme(String theme) async {
//     sharedPref.setString(themeKey, theme);
//   }

//   static Future<String> getAppTheme() async {
//     return sharedPref.getString(themeKey) ?? 'light';
//   }

//   // Auth User
//   static Future<void> setAuthUser(UserModel authUser) async {
//     String jsonAuthUser = jsonEncode(authUser.toJson());
//     sharedPref.setString(authUserKey, jsonAuthUser);
//     authUserNotifier.value = authUser;
//   }

//   static Future<void> removeAuthUser() async {
//     sharedPref.remove(authUserKey);
//     authUserNotifier.value = null;
//   }

//   static Future<UserModel?> getAuthUser() async {
//     final sharedPref = await SharedPreferences.getInstance();
//     var authUser = sharedPref.getString(authUserKey);
//     if (authUser != null) {
//       return UserModel.fromJson(jsonDecode(authUser));
//     }
//     return null;
//   }

//   // Access Token
//   static Future<void> setAccessToken(String accessToken) async {
//     sharedPref.setString(accessTokenKey, accessToken);
//     accessTokenNotifier.value = accessToken;
//   }

//   static Future<String?> getAccessToken() async {
//     final sharedPref = await SharedPreferences.getInstance();
//     return sharedPref.getString(accessTokenKey);
//   }

//   static Future<void> removeAccessToken() async {
//     sharedPref.remove(accessTokenKey);
//     accessTokenNotifier.value = null;
//   }

//   // Refresh Token
//   static Future<void> setRefreshToken(String refreshToken) async {
//     sharedPref.setString(refreshTokenKey, refreshToken);
//   }

//   static Future<String?> getRefreshToken() async {
//     return sharedPref.getString(refreshTokenKey);
//   }

//   static Future<void> removeRefreshToken() async {
//     sharedPref.remove(refreshTokenKey);
//   }

//   // Onboarding
//   static Future<void> setOnboardingStatus(bool status) async {
//     sharedPref.setBool(onboardingKey, status);
//   }

//   static Future<bool> getOnboardingStatus() async {
//     final sharedPref = await SharedPreferences.getInstance();
//     return sharedPref.getBool(onboardingKey) ?? true;
//   }

//   // Clear all
//   static Future<void> clearAll() async {
//     sharedPref.clear();
//   }
// }
