import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
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
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: palette.cryptexAreaColor
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22.0,8.0,22.0,8.0,),
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
                    fontSize: 32,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Divider(thickness: 1.0, color: palette.mainTextColor,),
              ),

              Column(
                children: displayErrors(errors, palette),
              ),              

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                        child: Text(
                          "Okay",
                          style: TextStyle(
                            color: palette.mainTextColor,
                            fontSize: 22,
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

List<Widget> displayErrors(List<String> errors, ColorPalette palette) {
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
            fontSize: 22,
            fontWeight: FontWeight.w300
          ),
          textAlign: TextAlign.start,
        ),
        Divider(thickness: 0.5, color: palette.clueCardTextColor ,)
      ],
    );
    errorTextWidgets.add(errorTextWidget);
  }
  return errorTextWidgets;
}