// import 'package:flutter/material.dart';
// import 'package:lock_words/functions/helpers.dart';
// import 'package:lock_words/providers/animation_state.dart';
// import 'package:lock_words/providers/game_play_state.dart';
// import 'package:lock_words/screens/game_screen/components/dial_letter.dart';
// import 'package:provider/provider.dart';

// class DialWidget extends StatefulWidget {
//   final int index;
//   final AnimationController scrollBackController;
//   const DialWidget({
//     super.key,
//     required this.index,
//     required this.scrollBackController,
//   });

//   @override
//   State<DialWidget> createState() => _DialWidgetState();
// }

// class _DialWidgetState extends State<DialWidget> with SingleTickerProviderStateMixin{


//   late Animation<double> scrollBackAnimation;

//   // late Animation<double> scrollBackAnimation;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initializeAnimations();
//   }

//   void initializeAnimations() {
//     scrollBackAnimation = Tween(begin:1.0,end: 0.0).animate(widget.scrollBackController);
//   }


//   List<Widget> getDialLetters(AnimationState animationState, GamePlayState gamePlayState, Animation<double> anim) {
//     List<Widget> res = [];

//     late double ts = gamePlayState.tileSize;
//     late double distanceY = Helpers().getDistanceY(gamePlayState);
//     late bool isTarget = Helpers().getIsTarget(gamePlayState, widget.index);
//     late List<String> wheelData = gamePlayState.wheelData[widget.index];

//     if (animationState.shouldRunScrollBackAnimation) {

//       Widget dialWidget0 = AnimatedBuilder(
//         animation: widget.scrollBackController,
//         builder: (context,child) {
//           return DialLetter(
//             offset: Offset(0,Helpers().getUpperPiece2Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2),),
//             angle: Helpers().getUpperPiece2Angle((distanceY*anim.value), ts,isTarget),
//             tileSize: ts, 
//             border: Helpers().getUpperPiece2Border((distanceY*anim.value),ts,isTarget), 
//             body: wheelData[0],
//             scrollBackController: widget.scrollBackController,
//           );
//         }
//       );      
//       Widget dialWidget1 = AnimatedBuilder(
//         animation: widget.scrollBackController,
//         builder: (context,child) {
//           return DialLetter(
//             offset: Offset(0,Helpers().getUpperPiece1Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2)),
//             angle: Helpers().getUpperPiece1Angle((distanceY*anim.value), ts,isTarget),
//             tileSize: ts, 
//             border: Helpers().getUpperPiece1Border((distanceY*anim.value),ts,isTarget), 
//             body: wheelData[1],
//             scrollBackController: widget.scrollBackController,
//           );
//         }
//       );
//       Widget dialWidget2 = AnimatedBuilder(
//         animation: widget.scrollBackController,
//         builder: (context,child) {
//           return DialLetter(
//             offset: Offset(0, (Helpers().getYOffset((distanceY*anim.value),isTarget)+(((ts*2.5)-ts)/2))),
//             angle: Helpers().getCenterPieceAngle((distanceY*anim.value), ts,isTarget),
//             tileSize: ts, 
//             border: Helpers().getCenterPieceBorder((distanceY*anim.value),ts,isTarget),
//             body: wheelData[2],
//             scrollBackController: widget.scrollBackController,
//           );
//         }
//       ); 

//       Widget dialWidget3 = AnimatedBuilder(
//         animation: widget.scrollBackController,
//         builder: (context,child) {
//           return DialLetter(
//             offset: Offset(0,Helpers().getLowerPiece1Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2),),
//             angle: Helpers().getLowerPiece1Angle((distanceY*anim.value), ts,isTarget),
//             tileSize: ts, 
//             border: Helpers().getLowerPiece1Border((distanceY*anim.value),ts,isTarget), 
//             body: wheelData[3],
//             scrollBackController: widget.scrollBackController,
//           );
//         }
//       ); 

//       Widget dialWidget4 = AnimatedBuilder(
//         animation: widget.scrollBackController,
//         builder: (context,child) {
//           return DialLetter(
//             offset: Offset(0,Helpers().getLowerPiece2Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2),),
//             angle: Helpers().getLowerPiece2Angle((distanceY*anim.value), ts,isTarget),
//             tileSize: ts, 
//             border: Helpers().getLowerPiece2Border((distanceY*anim.value),ts,isTarget), 
//             body: wheelData[4],
//             scrollBackController: widget.scrollBackController,
//           );
//         }
//       );             


//       res.add(dialWidget0);
//       res.add(dialWidget1);
//       res.add(dialWidget2);
//       res.add(dialWidget3);
//       res.add(dialWidget4);


//     } else {

//       Widget dialLetter0 = DialLetter(
//         offset: Offset(0,Helpers().getUpperPiece2Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2),),
//         angle: Helpers().getUpperPiece2Angle(distanceY, ts,isTarget),
//         tileSize: ts, 
//         border: Helpers().getUpperPiece2Border(distanceY,ts,isTarget), 
//         body: wheelData[0],
//         scrollBackController: widget.scrollBackController,
//       );
  

//       Widget dialLetter1 = DialLetter(
//         offset: Offset(0,Helpers().getUpperPiece1Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2)),
//         angle: Helpers().getUpperPiece1Angle(distanceY, ts,isTarget),
//         tileSize: ts, 
//         border: Helpers().getUpperPiece1Border(distanceY,ts,isTarget), 
//         body: wheelData[1],
//         scrollBackController: widget.scrollBackController,
//       );

//       Widget dialLetter2 = DialLetter(
//         offset: Offset(0,Helpers().getYOffset(distanceY,isTarget)+(((ts*2.5)-ts)/2),), 
//         angle: Helpers().getCenterPieceAngle(distanceY, ts,isTarget),
//         tileSize: ts, 
//         border: Helpers().getCenterPieceBorder(distanceY,ts,isTarget), 
//         body: wheelData[2],
//         scrollBackController: widget.scrollBackController,
//       );


//       Widget dialLetter3 = DialLetter(
//         offset: Offset(0,Helpers().getLowerPiece1Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2),),
//         angle: Helpers().getLowerPiece1Angle(distanceY, ts,isTarget),
//         tileSize: ts, 
//         border: Helpers().getLowerPiece1Border(distanceY,ts,isTarget), 
//         body: wheelData[3],
//         scrollBackController: widget.scrollBackController,
//       );

//       Widget dialLetter4 = DialLetter(
//         offset: Offset(0,Helpers().getLowerPiece2Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2),),
//         angle: Helpers().getLowerPiece2Angle(distanceY, ts,isTarget),
//         tileSize: ts, 
//         border: Helpers().getLowerPiece2Border(distanceY,ts,isTarget), 
//         body: wheelData[4],
//         scrollBackController: widget.scrollBackController,
//       ); 
//       res.add(dialLetter0);
//       res.add(dialLetter1);
//       res.add(dialLetter2);
//       res.add(dialLetter3);
//       res.add(dialLetter4);
//     }

//     return res;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AnimationState>(
//       builder: (context,animationState,child) {
//         return Consumer<GamePlayState>(
//           builder: (context,gamePlayState,child) {
//             late double ts = gamePlayState.tileSize;
//             late double distanceY = Helpers().getDistanceY(gamePlayState);
//             late bool isTarget = Helpers().getIsTarget(gamePlayState, widget.index);
//             late List<String> wheelData = gamePlayState.wheelData[widget.index];
        
//             return Container(
//               width: gamePlayState.tileSize,
//               height: gamePlayState.tileSize*2.5,
              
//               // color: getRandomColor(),
//               // color: Colors.blue,
//               child: Stack(
//                 children: getDialLetters(animationState, gamePlayState,scrollBackAnimation),
//               ),
//             );
//           }
//         );
//       }
//     );
//   }
// }


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/audio/sounds.dart';
import 'package:lock_words/functions/game_logic.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class DialWidget extends StatefulWidget {
  final int index;
  // final AnimationController animationController;
  const DialWidget({
    super.key,
    required this.index, 
    // required this.animationController
    });

  @override
  State<DialWidget> createState() => _DialWidgetState();
}

class _DialWidgetState extends State<DialWidget> {

  late FixedExtentScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FixedExtentScrollController(initialItem: 3);

    // Random rand = Random();
    // final int randIndex = rand.nextInt(4);
    // final int randDelay = rand.nextInt(3);

    // print("ring: ${widget.index} | randIndex: $randIndex ");

    // WidgetsBinding.instance.addPostFrameCallback((_) {
      // Future.delayed(Duration(milliseconds: randDelay*100), () {
      //   controller.animateToItem(
      //     randIndex,  // Target position
      //     duration: const Duration(milliseconds: 1500),  // Animation duration
      //     curve: Curves.easeOutBack,  // Animation curve
      //   );
      // });
    // });

    
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  // void executeSelectedItemChanged(GamePlayState gamePlayState, var details, int index) {
  //   List<String> wheel = gamePlayState.wheelData[index];
  //   // String letter = wheel[details];
  //   Map<dynamic,dynamic> activeLetterIndexes = gamePlayState.activeLetterIndexes;
  //   activeLetterIndexes.update(index, (_) => details);
  //   gamePlayState.setActiveLetterIndexes(activeLetterIndexes);
  //   // print(letter);
  //   // print("butt caca $details");
  //   print(gamePlayState.activeLetterIndexes);
  // }

  @override
  Widget build(BuildContext context) {
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    final AudioController audioController = Provider.of<AudioController>(context, listen: false);
    
    

    // Random rand = Random();
    // int randomIndex = rand.nextInt(4);
    // controller.animateToItem(randomIndex, duration: const Duration(milliseconds: 1000), curve: Curves.bounceIn);    
    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {

        // List<String> wheelData = gamePlayState.wheelData[widget.index.toString()];


        return Consumer<AnimationState>(
          builder: (context,animationState,child) {
            return Container(
              width: gamePlayState.tileSize*0.8,
              // height: gamePlayState.tileSize*2.5,
              height: settingsState.screenSizeData["cryptexHeight"],
              // height: (MediaQuery.of(context).size.height-100) * 0.4 * 0.8,
              
              // color: Colors.red,
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [Colors.brown, Colors.orange,Colors.white, Colors.orange, Colors.brown],
                //   stops: [0.0,             0.20,            0.40,          0.60,            0.80]
                // ),
                // border: Border(
                //   top: BorderSide(color: Colors.black, width: 2.0),
                //   bottom: BorderSide(color: Colors.black, width: 2.0),
                // )
              ),
              child: Center(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: (settingsState.screenSizeData["cryptexHeight"] * 0.25).round() * 1.0,
                  controller: controller,
                  physics: FixedExtentScrollPhysics(),
                  scrollBehavior: ScrollBehavior(),
                  perspective: 0.001,
                  offAxisFraction: 0.0,
                  diameterRatio: 1.1,
                  squeeze: 1.1,
                  onSelectedItemChanged: (details) {
                    audioController.playSfx(SfxType.tick,settingsState);
                    GameLogic().executeSelectedItemChanged(gamePlayState,animationState,details,widget.index,audioController,settingsState);
                  },
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: getWheelLetters(gamePlayState,widget.index),
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}

// Widget card(int index,List<String> items, double tileSize, bool active) {
//   return Container(
//     width: tileSize*0.7,
//     height: tileSize*0.7,
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.bottomLeft,
//         end: Alignment.topRight,
        
//         colors: active ? [Colors.green,Colors.green] : [
//           Color.fromARGB(255, 143, 189, 228),
//           Color.fromARGB(255, 227, 229, 245),
//         ]
//       ),
//       border: Border.all(color: const Color.fromARGB(255, 90, 90, 90), width: 1.0),
//       borderRadius: BorderRadius.all(Radius.circular(8.0))
//     ),
//     child: Center(
//       child: Text(
//         items[index],
//         style: TextStyle(
//           fontSize: 30
//         ),
//       ),
//     ),
//   );
// }

class DialLetter extends StatefulWidget {
  final int wheelId;
  final int letterId;
  // final AnimationController animationController;
  const DialLetter({
    super.key, 
    required this.wheelId, 
    required this.letterId,
    // required this.animationController,
  });

  @override
  State<DialLetter> createState() => _DialLetterState();
}

class _DialLetterState extends State<DialLetter> {

  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initializeAnimations();

  }

  // void initializeAnimations() {
  //   Color color_0 = Colors.blue;
  //   Color color_1 = Colors.pink;
    

  //   final List<TweenSequenceItem<Color?>> colorSequence = [
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_0,end: color_1,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_1,end: color_1,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_1,end: color_0,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_0,end: color_1,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_1,end: color_1,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_1,end: color_0,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_0,end: color_1,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_1,end: color_1,),weight: 10),
  //     TweenSequenceItem<Color?>(tween: ColorTween(begin: color_1,end: color_0,),weight: 10),            
  //   ];    
  //   colorAnimation = TweenSequence<Color?>(colorSequence).animate(widget.animationController);    
  // }

  @override
  Widget build(BuildContext context) {
    late GamePlayState gamePlayState = Provider.of<GamePlayState>(context, listen: false);
    late AnimationState animationState = Provider.of<AnimationState>(context, listen: false);
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);

    final double ts = gamePlayState.tileSize;
    List<dynamic> wheelData = gamePlayState.wheelData[widget.wheelId];

    // bool isHovered = 

    return Consumer<GamePlayState>(
      builder: (context, gamePlayState, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: ts,
          height: ts,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                // Color.fromARGB(255, 228, 201, 143),
                // Color.fromARGB(255, 245, 241, 227),
                // Color.fromRGBO(44, 44, 46, 1.0),
                // Color.fromRGBO(44, 44, 46, 1.0)
                palette.cryptexLetterTileColor,
                palette.cryptexLetterTileColor,
              ]
            ),
            // border: Border.all( color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
          child: Center(
            child: Text(
              wheelData[widget.letterId],
              style: TextStyle(
                fontSize: 30,
                color: palette.cryptexLetterColor
              ),
            ),
          ),
        );        
      },
    );

    // return Consumer<AnimationState>(
    //   builder: (context,animationState,child) {
        
    //     return Consumer<GamePlayState>(
    //       builder: (context,gamePlayState,child) {

    //         int? swipedWheelId = gamePlayState.swipedWheelId;
    //         Map<dynamic,dynamic> wheelIndexes = gamePlayState.activeLetterIndexes;
    //         bool isHover = false;
    //         if (gamePlayState.swipedWheelId != null) {
    //           if (widget.wheelId <= gamePlayState.swipedWheelId!) {
    //             if (wheelIndexes[widget.wheelId] == widget.letterId) {
    //               isHover = true;
    //             }
    //           }
    //         }
            
    //         // bool inWord = true;
    //         // if (animationState.shouldRunWordFoundAnimation) {
        
    //         // }

    //         bool isFoundWordLetter = false;
    //         String foundWordLetter = "";
    //         if (animationState.wordFoundWheelIndexes.isNotEmpty) {
    //           print(animationState.wordFoundWheelIndexes);
    //           // print("wheel id : ${widget.wheelId} | letter id : ${widget.letterId} ");
    //           if (animationState.wordFoundWheelIndexes[widget.wheelId] == widget.letterId) {
    //             isFoundWordLetter = true;
    //             foundWordLetter = gamePlayState.wheelData[widget.wheelId][widget.letterId];
    //           }
    //         }

    //         if (isFoundWordLetter) {
    //           return AnimatedBuilder(
    //             animation: widget.animationController,
    //             builder: (context, child) {
    //               return Container(
    //                 color: colorAnimation.value,
    //                 width: ts,
    //                 height: ts,
    //                 child: Center(
    //                   child: Text(
    //                     foundWordLetter,
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: ts*0.4
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }
    //           );
    //         } else {  

    //           return AnimatedContainer(
    //             duration: const Duration(milliseconds: 200),
    //             width: ts,
    //             height: ts,
    //             decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 begin: Alignment.bottomLeft,
    //                 end: Alignment.topRight,
    //                 colors: isHover ? [Colors.green, const Color.fromARGB(255, 172, 194, 173)] : [
    //                   Color.fromARGB(255, 228, 201, 143),
    //                   Color.fromARGB(255, 245, 241, 227),
    //                 ]
    //               ),
    //               border: isHover ?  
    //               Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 2.0)
    //               : Border.all( color: Colors.black, width: 1.0),
    //               borderRadius: BorderRadius.all(Radius.circular(8.0))
    //             ),
    //             child: Center(
    //               child: Text(
    //                 wheelData[widget.letterId],
    //                 style: TextStyle(
    //                   fontSize: 30
    //                 ),
    //               ),
    //             ),
    //           );
    //         }
    //       }
    //     );
    //   }
    // );
  }
}

List<Widget> getWheelLetters(GamePlayState gamePlayState, int index) {
  late List<Widget> res = [];

  for (int i=0; i<gamePlayState.wheelData[index].length; i++) {
    Widget tile = DialLetter(wheelId: index, letterId: i,);
    res.add(tile);
  }
  return res;
}