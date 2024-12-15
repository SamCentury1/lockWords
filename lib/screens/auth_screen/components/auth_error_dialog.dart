import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class AuthErrorDialog extends StatelessWidget {
  final String errorTitle;
  final List<String> errors;
  const AuthErrorDialog({
    super.key,
    required this.errorTitle,
    required this.errors,
  });

  @override
  Widget build(BuildContext context) {
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen:false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    final double sizeFactor = settingsState.sizeFactor;
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0 * sizeFactor)),
          color: palette.cryptexAreaColor
        ),
        child: Padding(
          padding:  EdgeInsets.fromLTRB(22.0 * sizeFactor,8.0 * sizeFactor,22.0 *sizeFactor, 8.0 * sizeFactor,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  errorTitle,
                  style: TextStyle(
                    color: palette.mainTextColor,
                    fontSize: 32 * sizeFactor,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0 * sizeFactor),
                child: Divider(thickness: 1.0 *sizeFactor, color: palette.mainTextColor,),
              ),

              Column(
                children: displayErrors(errors, palette, sizeFactor),
              ),              

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0 * sizeFactor),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: palette.clueCardFlippedColor
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12.0 * sizeFactor, 4.0 * sizeFactor, 12.0 * sizeFactor, 4.0 * sizeFactor),
                        child: Text(
                          "Okay",
                          style: TextStyle(
                            color: palette.mainTextColor,
                            fontSize: 22 * sizeFactor,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}

List<Widget> displayErrors(List<String> errors, ColorPalette palette, double sizeFactor) {
  List<Widget> errorTextWidgets = [];
  for (String error in errors) {
    late Widget errorTextWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,      
      children: [
        Text(
          error,
          style: TextStyle(
            color: palette.mainTextColor,
            fontSize: 22 * sizeFactor,
            fontWeight: FontWeight.w300
          ),
          textAlign: TextAlign.start,
        ),
        Divider(thickness: 0.5 * sizeFactor, color: palette.clueCardTextColor ,)
      ],
    );
    errorTextWidgets.add(errorTextWidget);
  }
  return errorTextWidgets;
}