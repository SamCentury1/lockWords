import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

class AuthProviderTile extends StatelessWidget {
  final ColorPalette palette;
  final Function()? onTap;
  final IconData iconData;
  const AuthProviderTile({
    super.key,
    required this.palette,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: palette.cryptexAreaColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0))
        ),
        child: Icon(iconData, size: 50, color: palette.clueCardTextColor,),
      ),
    );
  }
}