import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lock_words/providers/color_palette.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final String body;
  final ColorPalette palette;
  const LoginButton({
    super.key, 
    required this.onTap, 
    required this.body,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: palette.clueCardColor,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Center(
          child: Text(
            body,
            style: TextStyle(
              color: palette.mainTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 18.0
            ),
          ),
        ),
      ),
    );
  }
}