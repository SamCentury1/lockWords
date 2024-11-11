import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/clues/clue_widget.dart';
import 'package:lock_words/screens/game_screen/components/clues/hint_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CluesWidget extends StatefulWidget {
  final ItemScrollController itemScrollController;
  // final AnimationController animationController;
  final Map<String,AnimationController> hintControllers;
  final Map<dynamic,dynamic> hintAnimations;
  // final AnimationController flipController;
  // final List<Animation<double>> flipAnimations; 
  const CluesWidget({
    super.key,
    required this.itemScrollController,
    // required this.animationController,
    required this.hintControllers,
    required this.hintAnimations,
    // required this.flipController,
    // required this.flipAnimations,
  });

  @override
  State<CluesWidget> createState() => _CluesWidgetState();
}

class _CluesWidgetState extends State<CluesWidget> {
  // late FixedExtentScrollController scrollCluesController;

  List<GlobalKey> _keys = [];

  // @override
  // void initState() {
  //   super.initState();

  //   // Add a post-frame callback to calculate the height after the list is built.
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     double totalHeight = 0;

  //     for (GlobalKey key in _keys) {
  //       final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
  //       if (renderBox != null) {
  //         totalHeight += renderBox.size.height;
  //       }
  //     }

  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // scrollCluesController = FixedExtentScrollController(initialItem: 3);
  // }


  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   // scrollCluesController.dispose();
  //   super.dispose();
  // }

  // void _scrollDown() {
  //   scrollCluesController.animateTo(
  //     scrollCluesController.position.maxScrollExtent,
  //     duration: Duration(seconds: 2),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }  
  // final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  // final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

  
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     widget.itemScrollController.jumpTo(index: 20);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
    final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

    
    return SizedBox(
      width: settingsState.screenSizeData["width"],
      height: MediaQuery.of(context).size.height * 1.0,      
      child: Center(
        child: Consumer<GamePlayState>(
          builder: (context,gamePlayState,child) {
            final double ts = gamePlayState.tileSize;
            List<Widget> clues = getCluesList(gamePlayState);
            // widget.itemScrollController.jumpTo(index: gamePlayState.words.length);
            // itemPositionsListener.itemPositions.addListener(() {
            // //   print(itemPositionsListener.itemPositions.value.);
            // //   // gamePlayState.setClueSummaryViewData({
            // //   //   "first": itemPositionsListener.itemPositions.value.first.index,
            // //   //   "last": itemPositionsListener.itemPositions.value.last.index,          
            // //   // });
            // });

            // scrollOffsetListener.changes.listen((event) {
            //   gamePlayState.setClueOffsetPosition(gamePlayState.clueOffsetPosition + event);
            // });

            return Consumer<AnimationState>(
              builder: (context,animationState,child) {
                return Container(
                  width: settingsState.screenSizeData["width"]*0.9,
                  // height: settingsState.screenSizeData["cluesWidgetHeight"],
                  height: settingsState.screenSizeData["height"],
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(118, 223, 222, 222),
                    borderRadius: BorderRadius.all(Radius.circular(ts*0.2))
                
                  ),
                  child: ScrollablePositionedList.builder(
                    itemScrollController: widget.itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    scrollOffsetListener: scrollOffsetListener,
                    itemCount: clues.length+1,
                  
                    itemBuilder: (context,index) {
                      // late Map<dynamic,dynamic> value = {};
                      Map<String,dynamic> tappedClueData = gamePlayState.clueTappedIds;
                      if (index == gamePlayState.words.length) {
                        // return SizedBox(height: (settingsState.screenSizeData["height"]-100)*0.4,);
                        return SizedBox(height: settingsState.screenSizeData["cryptexHeight"],);
                      } else  {
                        if (index == tappedClueData["current"]) {
                          if (animationState.shouldRunShowHintAnimation) {
                            return HintAnimationWidget(
                              index: index, 
                              flipController: widget.hintControllers["show"]!, 
                              flipAnimations: widget.hintAnimations["show"],
                            );
                          } else {
                            return ClueWidget(
                              index: index,
                            );                        
                          }
                        } else if (index == tappedClueData["previous"]) {
                          if (animationState.shouldRunHideHintAnimation) {
                            return HintAnimationWidget(
                              index: index, 
                              flipController: widget.hintControllers["hide"]!, 
                              flipAnimations: widget.hintAnimations["hide"],
                            );                      
                          } else {
                            return ClueWidget(
                              index: index,
                            );                        
                          }
                        } else {
                          return ClueWidget(
                            index: index,
                          );
                        }          
                      }
                    },
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }
}

List<Widget> getCluesList(GamePlayState gamePlayState, ) {
  // Widget gap = SizedBox(height: gamePlayState.tileSize,);
  List<Widget> res = [];
  for (int i=0; i<gamePlayState.words.length; i++) {
    Widget widget = ClueWidget(index: i,);
    res.add(widget);    
  }
  // gamePlayState.words.forEach((key,value) {
  //   // Widget widget  = clue(gamePlayState,value);
  //   Widget widget = ClueWidget(index: key);
  //   res.add(widget);
  // });
  // // res.add(gap);
  // res.add(gap);
  // res.add(gap);
  return res;
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

// String hashWord(GamePlayState gamePlayState, int index) {
//   Map<int,dynamic> foundLetters = Helpers().getUnHashedLetters(gamePlayState);

//   Map<String,dynamic> wordData = gamePlayState.words[index];
//   String res = wordData["word"];
//   if (wordData["active"]) {
//     String bb = "";
//     List<String> letters = wordData["word"].split("");
//     for (int i = 0; i<letters.length; i++) {
//       List<dynamic> wheel = foundLetters[i];
//       if (wheel.contains(letters[i])) {
//         bb = bb + "${letters[i]}";
//       } else {
//         bb = bb + "*";
//       }
//     }
//     res = bb;
//   }
//   return res;
// }

// List<TableCell> displayClueWord(GamePlayState gamePlayState, int index) {
//   String hash = hashWord(gamePlayState, index);
//   List<String> characters = hash.split("");
//   List<TableCell> cells = [];
//   for (String letter in characters) {
//     TableCell cell =TableCell(
//       child: Center(
//         child: Text(
//           letter,
//           style: TextStyle(
//             fontSize: gamePlayState.tileSize*0.3,
//             color: gamePlayState.words[index]["active"] ? Colors.black : Color.fromARGB(122, 58, 58, 58) 
//           ),
//         )
//       ),
//     );
//     cells.add(cell);
//   }
//   return cells;
// }