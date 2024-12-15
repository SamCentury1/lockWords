import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class LoginTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final ColorPalette palette;
  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);

    final double sizeFactor = settingsState.sizeFactor ;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: palette.mainTextColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.0 * sizeFactor),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: palette.cryptexAreaColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: palette.cryptexAreaColor),
        ),
        focusColor: palette.mainTextColor,
        fillColor: palette.cryptexAreaColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: palette.clueCardTextColor,
          fontSize: 18 * sizeFactor,
        )
      ),
    );
  }
}