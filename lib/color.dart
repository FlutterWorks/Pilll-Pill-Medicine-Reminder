import 'package:flutter/widgets.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex({Color color, bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
}

class PilllColors {
  const PilllColors();

  static final Color primary = HexColor.fromHex("E37474");
  static final Color pillSheet = HexColor.fromHex("E8EBED");
  static final Color mat = HexColor.fromHex("FAFAFA").withAlpha(80);
  static final Color sunday = HexColor.fromHex("E17F7F");
  static final Color saturday = HexColor.fromHex("7FB9E1");
  static final Color weekday = HexColor.fromHex("7E7E7E");
}
