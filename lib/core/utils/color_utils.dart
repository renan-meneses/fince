import 'package:flutter/material.dart';

/// Parses a `#RRGGBB` string into a [Color], defaulting safely.
Color colorFromHex(String hex) {
  final value = int.tryParse(hex.replaceFirst('#', ''), radix: 16);
  return value == null ? const Color(0xFF0B6E4F) : Color(0xFF000000 | value);
}

/// Serializes a [Color] to a `#RRGGBB` string.
String colorToHex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
