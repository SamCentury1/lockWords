import 'package:flutter/material.dart';


class ColorPalette with ChangeNotifier {


  late Color _screenBackgroundColor = Color.fromRGBO(44, 44, 46, 1.0);
  Color get screenBackgroundColor => _screenBackgroundColor;

  late Color _cryptexAreaColor = const Color.fromRGBO(28,28,30,1.0);
  Color get cryptexAreaColor => _cryptexAreaColor;

  late Color _cryptexLetterTileColor = Color.fromRGBO(44, 44, 46, 1.0);
  Color get cryptexLetterTileColor => _cryptexLetterTileColor;  

  late Color _cryptexLetterColor = Colors.white;
  Color get cryptexLetterColor => _cryptexLetterColor;

  late Color _clueCardColor = Color.fromARGB(255, 68, 51, 116);
  Color get clueCardColor => _clueCardColor;  

  late Color _clueCardFlippedColor = Color.fromARGB(255, 129, 98, 214);
  Color get clueCardFlippedColor => _clueCardFlippedColor;
    
  late Color _clueCardTextColor = const Color.fromARGB(255, 187, 182, 182);
  Color get clueCardTextColor => _clueCardTextColor;     

  late Color _mainTextColor = Colors.white;
  Color get mainTextColor => _mainTextColor;

  late Color _overlayColor = Colors.black;
  Color get overlayColor => _overlayColor;  

  late Color _overlayTextColor =  Colors.white;
  Color get overlayTextColor => _overlayTextColor;

  late Color _glowColor =  Colors.white;
  Color get glowColor => _glowColor;    

  void getThemeColors(String theme) {
    switch (theme) {
      case "dark":
        _screenBackgroundColor = Color.fromRGBO(44, 44, 46, 1.0);
        _cryptexAreaColor = const Color.fromRGBO(28,28,30,1.0);
        _cryptexLetterTileColor = Color.fromRGBO(44, 44, 46, 1.0);
        _cryptexLetterColor = Colors.white;
        _mainTextColor = Colors.white;
        _clueCardColor = Color.fromARGB(255, 68, 51, 116);
        _clueCardFlippedColor = Color.fromARGB(255, 129, 98, 214);
        _clueCardTextColor = const Color.fromARGB(255, 187, 182, 182);
        _overlayColor = Colors.black;
        _overlayTextColor = Colors.white;
        _glowColor = Colors.white;
          

        break;
      case "light":
        _screenBackgroundColor = const Color.fromARGB(255, 224, 223, 223);
        _cryptexAreaColor = const Color.fromARGB(255, 255, 255, 255);
        _cryptexLetterTileColor = const Color.fromARGB(255, 190, 190, 190);
        _cryptexLetterColor = const Color.fromARGB(255, 32, 32, 32);
        _mainTextColor = const Color.fromARGB(255, 65, 65, 65);
        _clueCardColor = Color.fromARGB(255, 51, 77, 116);
        _clueCardFlippedColor = Color.fromARGB(255, 98, 168, 214);
        _clueCardTextColor = const Color.fromARGB(255, 243, 241, 241);
        _overlayColor = Colors.black;
        _overlayTextColor = Colors.white;
        _glowColor = Colors.white;             

        break;
      case "ocean":
        _screenBackgroundColor = const Color.fromARGB(255, 98, 163, 248); 
        _cryptexAreaColor = const Color.fromARGB(255, 23, 58, 153); 
        _cryptexLetterTileColor = const Color.fromARGB(255, 66, 160, 248);
        _cryptexLetterColor = const Color.fromARGB(255, 233, 242, 250);
        _mainTextColor = const Color.fromARGB(255, 248, 248, 248);
        _clueCardColor = Color.fromARGB(255, 51, 77, 116);
        _clueCardFlippedColor = Color.fromARGB(255, 164, 191, 223);
        _clueCardTextColor = const Color.fromARGB(255, 243, 241, 241);
        _overlayColor = Colors.black;
        _overlayTextColor = Colors.white;
        _glowColor = Colors.white;     

        break;
      case "forest":
        _screenBackgroundColor = const Color.fromARGB(255, 220, 243, 195);
        _cryptexAreaColor = const Color.fromARGB(255, 216, 236, 204);
        _cryptexLetterTileColor = const Color.fromARGB(255, 160, 223, 108);
        _cryptexLetterColor = const Color.fromARGB(255, 31, 31, 30);
        _mainTextColor = const Color.fromARGB(255, 29, 28, 28);
        _clueCardColor = Color.fromARGB(255, 149, 212, 104);
        _clueCardFlippedColor = Color.fromARGB(255, 187, 233, 155);
        _clueCardTextColor = const Color.fromARGB(255, 29, 29, 29);
        _overlayColor = Colors.black;
        _overlayTextColor = Colors.white;
        _glowColor = Colors.white;   

      //   break;
      // case "nature":


      //   break;                
      // case "ocean":


          break;                


    }
    notifyListeners();
  }
  
}