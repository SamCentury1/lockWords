
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

Future<void> openRewardDialog(BuildContext context, ColorPalette palette, VoidCallback onTap) {
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: palette.cryptexAreaColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Watch a short Video to acquire more coins!",
                  style: TextStyle(
                    color: palette.mainTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w300
                  ),
                ),
  
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
                    GestureDetector(
                      onTap: () {
                        // Dismiss the dialog before showing the ad
                        Navigator.of(context).pop();
                        // Show the ad
                        onTap();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: palette.clueCardColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                          child: Text(
                            "Watch!",
                            style: TextStyle(
                              color: palette.mainTextColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),                  
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}


