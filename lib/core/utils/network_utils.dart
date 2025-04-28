import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkUtils {
  /// Opens the network settings page on both Android and iOS
  static Future<void> openInternetSettings() async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.WIFI_SETTINGS',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    } else if (Platform.isIOS) {
      final Uri url = Uri.parse('App-Prefs:WIFI');
      if (!await launchUrl(url)) {
        throw 'Could not open WiFi settings on iOS';
      }
    } else {
      throw 'Unsupported platform';
    }
  }
}
