import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/home_screen/level_info_dialogs/game_completed_dialog.dart';
import 'package:lock_words/screens/home_screen/level_info_dialogs/game_not_started_dialog.dart';
import 'package:lock_words/screens/home_screen/level_info_dialogs/game_started_dialog.dart';
import 'package:provider/provider.dart';

class LevelInfoDialog extends StatefulWidget {
  final int index;
  final Map<dynamic,dynamic> levelData;
  const LevelInfoDialog({
    super.key,
    required this.index,
    required this.levelData,
  });

  @override
  State<LevelInfoDialog> createState() => _LevelInfoDialogState();
}

class _LevelInfoDialogState extends State<LevelInfoDialog> {


  @override
  Widget build(BuildContext context) {
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    late GamePlayState gamePlayState = Provider.of<GamePlayState>(context, listen:false);

    final Map<dynamic,dynamic> levelData = widget.levelData;
  

    if (levelData["playedData"].isNotEmpty) {
      if (levelData["playedData"]["completed"]) {
        return GameCompletedDialog(
          palette: palette, 
          levelData: levelData,
        );
      } else {
        return GameStartedDialog(
          palette: palette, 
          levelData: levelData, 
          navigateToLevel: () => Helpers().navigateToStartedLevel(levelData["level"],context,settingsState,gamePlayState)
        );
      }
    } else {
      return GameNotStartedDialog(
        palette: palette, 
        levelData: levelData, 
        navigateToLevel: () => Helpers().navigateToLevel(levelData["level"],context,settingsState,gamePlayState)
      );
    }
  }
}


// class GamePlayedDialog extends StatelessWidget {
//   final ColorPalette palette;
//   final Map<dynamic,dynamic> levelData;
//   const GamePlayedDialog({
//     super.key,
//     required this.palette,
//     required this.levelData
//   });

//   @override
//   Widget build(BuildContext context) {

//     final DateFormat formatter = DateFormat('MMM. dd, yyyy');
//     final DateTime date = DateTime.parse(levelData["playedData"]["createdAt"]);
//     final String formatted = formatter.format(date);
//     final String completedTimeString = Helpers().formatTime(levelData["playedData"]["time"]);

//     return Dialog(
//       insetPadding: EdgeInsets.all(30.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0))
//       ),
//       backgroundColor: palette.cryptexAreaColor,
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   levelData["level"],
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: palette.mainTextColor
//                   ),
//                 ),
//               ),


//               Divider(thickness: 0.5, color: Colors.grey.shade400,),

//               Container(
//                 height: 100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.star, size: 22, color: palette.mainTextColor,),
//                         SizedBox(width: 50, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Divider(thickness: 1.0, color: palette.mainTextColor,),
//                         ),),
//                         Text(
//                           "${levelData["playedData"]["score"].toString()} points",
//                           style: TextStyle(
//                             color: palette.mainTextColor,
//                             fontSize: 22
//                           ),
//                         ),
//                       ],
//                     ),
                
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.timer, size: 22, color: palette.mainTextColor,),
//                         SizedBox(width: 50, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Divider(thickness: 1.0, color: palette.mainTextColor,),
//                         ),),
//                         Text(
//                           completedTimeString,
//                           style: TextStyle(
//                             color: palette.mainTextColor,
//                             fontSize: 22
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               Divider(thickness: 0.5, color: palette.mainTextColor,),

//               Text(
//                 "solved on ${formatted}",
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: palette.mainTextColor
//                 )
//               ),              
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }


// class GameNotPlayedDialog extends StatelessWidget {
//   final ColorPalette palette;
//   final Map<dynamic,dynamic> levelData;
//   final Function()? navigateToLevel; 
//   const GameNotPlayedDialog({
//     super.key,
//     required this.palette,
//     required this.levelData,
//     required this.navigateToLevel,
//   });

//   @override
//   Widget build(BuildContext context) {

//     late int values = 0;
//     late int cluesLength = 0;

//     levelData["clues"].forEach((key,value){
//       values = values + value["value"] as int;
//       cluesLength++;
//     });
        
//     return Dialog(
//       insetPadding: EdgeInsets.all(30.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0))
//       ),
//       backgroundColor: palette.cryptexAreaColor,
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: SizedBox(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   levelData["level"],
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: palette.mainTextColor
//                   ),
//                 ),
//               ),
//               Divider(thickness: 0.5, color: palette.mainTextColor,),
//               Container(
//                 height: 100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.question_mark, size: 22, color: palette.mainTextColor,),
//                         SizedBox(width: 50, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Divider(thickness: 1.0, color: palette.mainTextColor,),
//                         ),),
//                         Text(
//                           "$cluesLength clues",
//                           style: TextStyle(
//                             color: palette.mainTextColor,
//                             fontSize: 22
//                           ),
//                         ),
//                       ],
//                     ),
                
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.star, size: 22, color: palette.mainTextColor,),
//                         SizedBox(width: 50, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Divider(thickness: 1.0, color: palette.mainTextColor,),
//                         ),),
//                         Text(
//                           "$values points available",
//                           style: TextStyle(
//                             color: palette.mainTextColor,
//                             fontSize: 22
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               Divider(thickness: 0.5, color: palette.mainTextColor,),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: navigateToLevel,
//                     child: Container(
//                       width: 100,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                         color: palette.clueCardFlippedColor,
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Play",
//                           style: TextStyle(
//                             color: palette.clueCardTextColor,
//                             fontSize: 20
//                           ),
//                         ),
//                       ),
                    
//                     ),
//                   )
//                 ],
//               )

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// class GameStartedDialog extends StatelessWidget {
//   final ColorPalette palette;
//   final Map<dynamic,dynamic> levelData;
//   final Function()? navigateToLevel; 
//   const GameStartedDialog({
//     super.key,
//     required this.palette,
//     required this.levelData,
//     required this.navigateToLevel,
//   });

//   @override
//   Widget build(BuildContext context) {

//     late int values = 0;
//     late int cluesLength = 0;

//     levelData["clues"].forEach((key,value){
//       values = values + value["value"] as int;
//       cluesLength++;
//     });

//     final DateFormat formatter = DateFormat('MMM. dd, yyyy');
//     final DateTime date = DateTime.parse(levelData["playedData"]["createdAt"]);
//     final String formatted = formatter.format(date);
//     final String completedTimeString = Helpers().formatTime(levelData["playedData"]["time"]);    
        
//     return Dialog(
//       insetPadding: EdgeInsets.all(30.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0))
//       ),
//       backgroundColor: palette.cryptexAreaColor,
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: SizedBox(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   levelData["level"],
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: palette.mainTextColor
//                   ),
//                 ),
//               ),
//               Divider(thickness: 0.5, color: palette.mainTextColor,),
//               Container(
//                 height: 100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.question_mark, size: 22, color: palette.mainTextColor,),
//                         SizedBox(width: 50, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Divider(thickness: 1.0, color: palette.mainTextColor,),
//                         ),),
//                         Text(
//                           "$cluesLength clues",
//                           style: TextStyle(
//                             color: palette.mainTextColor,
//                             fontSize: 22
//                           ),
//                         ),
//                       ],
//                     ),
                
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.star, size: 22, color: palette.mainTextColor,),
//                         SizedBox(width: 50, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Divider(thickness: 1.0, color: palette.mainTextColor,),
//                         ),),
//                         Text(
//                           "$values points available",
//                           style: TextStyle(
//                             color: palette.mainTextColor,
//                             fontSize: 22
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               Divider(thickness: 0.5, color: palette.mainTextColor,),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: navigateToLevel,
//                     child: Container(
//                       width: 100,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                         color: palette.clueCardFlippedColor,
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Resume",
//                           style: TextStyle(
//                             color: palette.clueCardTextColor,
//                             fontSize: 20
//                           ),
//                         ),
//                       ),
                    
//                     ),
//                   )
//                 ],
//               )

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }