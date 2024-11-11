import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:provider/provider.dart';

class ClueWidget extends StatefulWidget {
  final int index;
  // final AnimationController flipController;
  // final List<Animation<double>> flipAnimations;
  // final AnimationController animationController;
  
  const ClueWidget({
    Key? key,
    required this.index,
    // required this.flipController,
    // required this.flipAnimations,
    // required this.animationController,
  }) : super(key:key);

  @override
  State<ClueWidget> createState() => _ClueWidgetState();
}

class _ClueWidgetState extends State<ClueWidget> with TickerProviderStateMixin{

  late Animation<Color?> colorAnimation;
  late int randomIndex = 0;

  // late AnimationController flipController;
  // late Animation<double> flipAngleAnimation;

  // late AnimationController flipVisibilityController;
  // late Animation<double> flipVisibilityAnimation;

  // late AnimationState _animationState;
  // late GamePlayState _gamePlayState;

  late String hint = "";

  // final Map<dynamic,dynamic> colors = {
  //   0: [Color.fromRGBO(128, 128, 128, 1),Color.fromRGBO(129, 129, 129, 1),],
  //   1: [Color.fromRGBO(99, 99, 99, 1),Color.fromRGBO(151, 151, 151, 1),],
  //   2: [Color.fromRGBO(88, 88, 88, 1),Color.fromRGBO(105, 105, 105, 1),],
  //   3: [Color.fromRGBO(121, 121, 121, 1),Color.fromRGBO(109, 109, 109, 1),],
  //   4: [Color.fromRGBO(68, 68, 68, 1),Color.fromRGBO(75, 75, 75, 1),],
  // };

  late bool clueSide = true;

  late double angle = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Random rand = Random();
    randomIndex = rand.nextInt(5);
    // _animationState = Provider.of<AnimationState>(context, listen: false);
    // _gamePlayState = Provider.of<GamePlayState>(context, listen: false);
    // _animationState.addListener(handleAnimationStateChanges);
    // _gamePlayState.addListener(handleAnimationStateChanges);
    // initializeAnimations();
  }

  // void initializeAnimations() {
  //     flipController = AnimationController(
  //       duration: const Duration(milliseconds: 5000),
  //       vsync: this,
  //     );

  //     List<TweenSequenceItem<double>> flipAnimationSequence = [
  //       TweenSequenceItem(tween: Tween(begin: 0.00, end: 180), weight: 10),
  //     ];      

  //     flipAngleAnimation  = TweenSequence<double>(flipAnimationSequence).animate(flipController);  

  //     List<TweenSequenceItem<double>> flipVisibilityAnimationSequence = [
  //       TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00), weight: 50),
  //       TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00), weight: 50),
  //     ];      

  //     flipVisibilityAnimation  = TweenSequence<double>(flipVisibilityAnimationSequence).animate(flipController);               
  // }

  // void initializeAnimations() {
  //   Color color_0 = Colors.blue;
  //   Color color_1 = Colors.pink;

  //   colorAnimation = ColorTween(begin:color_0,end: color_1).animate(widget.animationController);    
  // }

  // void handleAnimationStateChanges() {

  //   Map<String,dynamic> animatedClues = _animationState.clueTappedIds;
  //   if (_animationState.shouldRunShowHintAnimation) {

  //     // Map<String,dynamic> clue = _gamePlayState.words[widget.index];

  //     if (animatedClues["current"] == widget.index) {
  //       print("executing the show for clue id ${widget.index}");
  //       executeShowHintAnimation();
  //     }
  //     // if (!clue["hintOpen"]) {

  //     // }
  //     // executeShowHintAnimation();
  //     // executeAnimations(clue["hintOpen"]);

      
  //   }

  //   if (_animationState.shouldRunHideHintAnimation) {

  //     if (animatedClues["previous"] == widget.index) {
  //       print("executing the hide for clue id ${widget.index}");
  //       executeHideHintAnimation();
  //     }
  //   }
  // }

  // void executeShowHintAnimation() {
  //   flipController.reset();
  //   flipController.forward();    
  // }

  // void executeHideHintAnimation() {
  //   flipController.reverse();
  // }  
  // void executeAnimations(bool isOpen) {
  //   if (!isOpen) {
  //     flipController.reverse();
  //     flipVisibilityController.reverse();      
  //   } else {
  //     flipController.reset();
  //     flipController.forward();
  //     flipVisibilityController.reset();
  //     flipVisibilityController.forward();      
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    final AudioController audioController = Provider.of<AudioController>(context, listen: false);
    final SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    return Consumer<GamePlayState>(
      builder: (context, gamePlayState, child) {

        hint = getClueWordHint(gamePlayState,widget.index);
        Map<dynamic,dynamic> clueData = gamePlayState.words[widget.index];
        // late String hashWord = hashWord(gamePlayState,widget.index);
        
        
        double ts = gamePlayState.tileSize;

        
        return Consumer<AnimationState>(
          builder: (context, animationState, child) {


            return Opacity(
              opacity: clueData["active"] ? 1.0 : 0.3,
              child: GestureDetector(

                onTapDown: (TapDownDetails details) {
                  gamePlayState.setClueTappedPosition(details.globalPosition);
                },

                onTapCancel: () {
                  gamePlayState.setClueTappedPosition(null);
                },

                // onTapUp: (TapUpDetails details) {
                //   gamePlayState.setClueTappedPosition(null);
                // } ,

                onTap: () {
                  if (gamePlayState.coins > 3) {
                    Helpers().getClueTappedId(gamePlayState,animationState,widget.index, audioController,settingsState);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 1000),
                        content: Text('Not enough coins for a hint!'),
                      ),
                    );
                  }
                },
                child: !clueData["hintOpen"] ? 
                
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   begin: Alignment.bottomRight,
                          //   end: Alignment.topRight,
                          //   colors: colors[randomIndex],
                          //   stops: const [0.5, 0.9]
                          // ),
                          color: palette.clueCardColor, //  Color.fromARGB(255, 68, 51, 116),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  clueData["clue"],
                                  style: TextStyle(
                                    fontSize: ts*0.32,
                                    decoration: clueData["active"] ? TextDecoration.none : TextDecoration.lineThrough,
                                    // color: clueData["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
                                    color: palette.clueCardTextColor //const Color.fromARGB(255, 187, 182, 182)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                :
              
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   begin: Alignment.bottomRight,
                              //   end: Alignment.topRight,
                              //   colors: colors[randomIndex],
                              //   stops: const [0.5, 0.9]
                              // ),
                              // color: Colors.brown,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(child:SizedBox()),
                                  Flexible(
                                    child: Text(
                                      clueData["clue"],
                                      style: TextStyle(
                                        fontSize: ts*0.32,
                                        decoration: clueData["active"] ? TextDecoration.none : TextDecoration.lineThrough,
                                        // color: clueData["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
                                        color: const Color.fromARGB(0, 0, 0, 0)
                                      ),
                                    ),
                                  ),
                                  // Expanded(child:SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              
              
                    Positioned(
                      bottom: 0,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color:palette.clueCardFlippedColor
                          ),                      
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,2.0),
                            child: Container(
                              // color: Colors.orange,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  hint,
                                  style: TextStyle(
                                    fontSize: ts*0.32,
                                    color: palette.clueCardTextColor,
                                    letterSpacing: 10.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ),               
                  ],
                )              
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0.0,6.0,0.0,6.0),
                //   child: Positioned(
                //     bottom: 0,
                //     top: 0,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //       color: Color.fromRGBO(76, 175, 79,1 ),
                //       child: Align(
                //         alignment: Alignment.center,
                //         child: Text(
                //           hint,
                //           style: TextStyle(
                //             fontSize: ts*0.32,
                //             color: Colors.white.withOpacity(1),
                //             letterSpacing: 10.0
                //           ),
                //         ),
                //       ),
                //     )
                //   ),
                // ),
                
              
                // child: Padding(
                //   padding: const EdgeInsets.fromLTRB(0.0,6.0,0.0,6.0),
                //   child: Stack(
                //     children:[
                //       Transform(
                //         transform: Matrix4.identity()
                //         ..setEntry(3, 2, 0.001)
                //         // ..rotateX((-flipAngleAnimation.value/180.0*pi)),
                //         ..rotateX(0.0),
                //         alignment: Alignment.center,
                //         child: Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(8.0))
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,2.0),
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 gradient: LinearGradient(
                //                   begin: Alignment.bottomRight,
                //                   end: Alignment.topRight,
                //                   colors: colors[randomIndex],
                //                   stops: const [0.5, 0.9]
                //                 ),
                //                 borderRadius: BorderRadius.all(Radius.circular(gamePlayState.tileSize*0.1))
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Row(
                //                   children: [
                //                     Flexible(
                //                       child: Text(
                //                         clueData["clue"],
                //                         style: TextStyle(
                //                           fontSize: ts*0.32,
                //                           decoration: clueData["active"] ? TextDecoration.none : TextDecoration.lineThrough,
                //                           // color: clueData["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
                //                           color: const Color.fromARGB(255, 187, 182, 182)
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                
                
                //       Positioned(
                //         bottom: 0,
                //         top: 0,
                //         left: 0,
                //         right: 0,
                //         child: Transform(
                //           transform: Matrix4.identity()
                //           ..setEntry(3, 2, 0.001)
                //           // ..rotateX((-flipAngleAnimation.value/180.0*pi)),
                //           ..rotateX(0.0),
                //           alignment: Alignment.center,
                //           child: Transform(
                //             transform: Matrix4.identity()
                //             ..setEntry(3, 2, 0.001)
                //             ..rotateX((180/180.0*pi)),
                //             alignment: Alignment.center,
                //             child: Container(
                //               color: Color.fromRGBO(76, 175, 79, 0.99 * flipVisibilityAnimation.value ),
                //               child: Align(
                //                 alignment: Alignment.center,
                //                 child: Text(
                //                   hint,
                //                   style: TextStyle(
                //                     fontSize: ts*0.32,
                //                     color: Colors.white.withOpacity(flipVisibilityAnimation.value),
                //                     letterSpacing: 10.0
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         )
                //       )
                //     ] 
                //   ),
                // ),
              ),
            );
          }
        );
      }
    );

  }
}

// Widget clue(GamePlayState gamePlayState, Map<dynamic,dynamic> clueData) {
//   final double ts = gamePlayState.tileSize;
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(0.0,6.0,0.0,6.0),
//     child: Container(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(8.0))
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,2.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: ts*0.5,
//                     child:Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: clueData["active"] ? const Color.fromARGB(255, 241, 214, 174) : Color.fromARGB(47, 241, 214, 174) ,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(8.0),
//                             topRight: Radius.circular(8.0),
//                           ),
//                         ),
//                         width: gamePlayState.tileSize*2,
//                         height: ts*0.5,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Center(
//                             child: Table(
//                               children: [
//                                 TableRow(
//                                   children: displayClueWord(gamePlayState,clueData["key"])
//                                 )
//                               ],
//                             )
//                           ),
//                         ),
//                       ),
//                     ),                             
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: clueData["active"] ? const Color.fromARGB(255, 241, 214, 174) : Color.fromARGB(66, 241, 214, 174) ,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft:  Radius.circular(8.0),
//                         topRight:  Radius.circular(8.0),
//                         bottomRight:  Radius.circular(8.0),
//                       )
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: Text(
//                               clueData["clue"],
//                               style: TextStyle(
//                                 fontSize: ts*0.28,
//                                 decoration: clueData["active"] ? TextDecoration.none : TextDecoration.lineThrough,
//                                 color: clueData["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ),
//       ),
//     ),
//   );
// }



// void executeClueTap(GamePlayState gamePlayState, int clueIndex) {
//   bool hintOpen = gamePlayState.words[clueIndex]["hintOpen"];
//   gamePlayState.words.forEach((key,value) {
//     if (key == clueIndex) {
//       value.update("hintOpen", (v) => !hintOpen);
//     } else {
//       value.update("hintOpen", (v) => false);
//     }
//   });


//   // print(gamePlayState.words);
//   // gamePlayState.set
// }

String getClueWordHint(GamePlayState gamePlayState, int clueIndex) {
  Map<dynamic,dynamic> wheelData = gamePlayState.wheelData;
  Map<dynamic,dynamic> letterIndexes = gamePlayState.activeLetterIndexes;

  Map<String,dynamic> clue = gamePlayState.words[clueIndex];  

  late String res = "";
  for (int i=0; i< wheelData.length; i++) {
    String currentLetter = wheelData[i][letterIndexes[i]];
    String clueLetter = clue["word"][i];
    if (currentLetter == clueLetter) {
      res = res + clueLetter;
    } else {
      res = res + "*";
    }
  
  }
  if (clue["active"]==false) {
    res = clue["word"];
  }

  return res;
}

String hashWord(GamePlayState gamePlayState, int index) {
  Map<int,dynamic> foundLetters = Helpers().getUnHashedLetters(gamePlayState);

  Map<String,dynamic> wordData = gamePlayState.words[index];
  String res = wordData["word"];
  if (wordData["active"]) {
    String bb = "";
    List<String> letters = wordData["word"].split("");
    for (int i = 0; i<letters.length; i++) {
      List<dynamic> wheel = foundLetters[i];
      if (wheel.contains(letters[i])) {
        bb = bb + "${letters[i]}";
      } else {
        bb = bb + "*";
      }
    }
    res = bb;
  }
  return res;
}

List<TableCell> displayClueWord(GamePlayState gamePlayState, int index) {
  String hash = hashWord(gamePlayState, index);
  List<String> characters = hash.split("");
  List<TableCell> cells = [];
  for (String letter in characters) {
    TableCell cell =TableCell(
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: gamePlayState.tileSize*0.3,
            color: gamePlayState.words[index]["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
          ),
        )
      ),
    );
    cells.add(cell);
  }
  return cells;
}