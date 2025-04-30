import 'package:flutter/material.dart';
import 'package:pashboi/features/user/data/models/user_model.dart';

final ValueNotifier<UserModel?> authUserNotifier = ValueNotifier(null);
final ValueNotifier<String?> accessTokenNotifier = ValueNotifier(null);
final ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
