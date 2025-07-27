import 'dart:convert';
import 'package:flutter/material.dart';

class Base64ImageWidget {
  final String base64String;

  Base64ImageWidget({required this.base64String});

  ImageProvider get imageProvider {
    final decodedBytes = base64Decode(base64String);
    return MemoryImage(decodedBytes);
  }
}
