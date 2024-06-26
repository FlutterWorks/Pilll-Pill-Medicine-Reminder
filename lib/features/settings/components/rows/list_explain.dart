import 'package:flutter/material.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';

class ListExplainRow extends StatelessWidget {
  final String text;

  const ListExplainRow({
    super.key,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text,
          style: const TextStyle(
            fontFamily: FontFamily.japanese,
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: TextColor.darkGray,
          )),
    );
  }
}
