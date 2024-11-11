import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';

Widget drawerItemHeader(ColorPalette palette, String body, Icon iconData, double sizeFactor) {
  return SizedBox(
    width: double.infinity,
    // height: 100,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * sizeFactor),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10 * sizeFactor),
                  child: Container(
                    width: double.infinity, 
                    height:1.0 * sizeFactor, 
                    color: palette.mainTextColor,
                  ),
                ),
              ),
              Text(
                body,
                style: TextStyle(
                  color: palette.mainTextColor,
                  fontSize: 28 * sizeFactor,
                  fontWeight: FontWeight.w300
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10 * sizeFactor),
                  child: Container(
                    width: double.infinity, 
                    height:1.0 * sizeFactor, 
                    color: palette.mainTextColor,
                  ),
                ),
              ),
          
            ],
          ),
          Center(
            child: Icon(iconData.icon, size: 22 * sizeFactor, color: palette.clueCardTextColor.withOpacity(0.7),),
          )
        ],
      ),
    ),
  ); 
}