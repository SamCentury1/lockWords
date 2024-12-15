import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

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
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    final double sizeFactor = settingsState.sizeFactor;    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80 * sizeFactor,
        height: 80 * sizeFactor,
        decoration: BoxDecoration(
          color: palette.cryptexAreaColor,
          borderRadius: BorderRadius.all(Radius.circular(12.0 * sizeFactor))
        ),
        child: Icon(iconData, size: 50 * sizeFactor, color: palette.clueCardTextColor,),
      ),
    );
  }
}