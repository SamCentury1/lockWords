import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lock_words/functions/game_logic.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/dial_widget.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {

  late double horizontalDragValue = 0.0;
  late double localPosX = 0.0;
  late AnimationState animationState;
  late AnimationController scrollBackController;

  // bool getIsDraggedOver(int index, double tileSize, double horizontalValue, double localX) {
  //   late bool res = false;
  //   double lowBound = index*(tileSize+5);
  //   double upBound = 4*(tileSize+5);
  //   if (horizontalValue >= 0 && localX >= lowBound && localX <= upBound) {
  //     res = true;
  //   }
  //   return res;
  // }

  late double _screenWidth = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final GamePlayState gamePlayState = Provider.of<GamePlayState>(context, listen: false);
      final SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);    

      final screenwidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      final AppBar appBar = AppBar();
      late double appBarHeight = appBar.preferredSize.height;

      final playScreenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBarHeight;
      
      _screenWidth = screenwidth;

      final double playAreaHeight = screenHeight;
      final double playAreaWidth = screenwidth > 600.0 ? 600.0 : screenwidth;
      final double minTileSize = playAreaHeight / 9;
      final double maxTileSize = (playAreaWidth * 0.95) / 6;
      late double tileSize = 0.0;

      if (minTileSize > maxTileSize) {
        tileSize = maxTileSize;
      } else {
        tileSize = minTileSize;
      }
      gamePlayState.setTileSize(tileSize);         
      
      
      print("tileSize: ${tileSize}");
      print("lock widget height: ${tileSize*3}");
      print("total game play height = ${playScreenHeight} ");
      print("the lock widget takes up ${(((tileSize*3)/playScreenHeight)*100).round()}% of the height");
      double lockWidgetShare = (((tileSize*4)/playScreenHeight));
      double lockWidgetHeight = lockWidgetShare*playScreenHeight;
      print("which is ${(playScreenHeight*0.69)/tileSize} tiles");

      double topWidgetShare = (tileSize/playAreaHeight);
      double topWidgetHeight = topWidgetShare*playAreaHeight;
      double gap = 0.1;
      double cluesWidgetShare = (1-topWidgetShare-lockWidgetShare-gap); 
      double cluesWidgetHeight = cluesWidgetShare*playAreaHeight; 


      settingsState.setScreenSizeData({
        "width": screenwidth, 
        "height": screenHeight,
        "lockWidgetHeight": lockWidgetHeight,
        "cluesWidgetHeight": cluesWidgetHeight,
        "topWidgetHeight":topWidgetHeight,            
      });
    });


    animationState = Provider.of<AnimationState>(context,listen: false);

    initializeAnimations();
    animationState.addListener(handleAnimationStateChange);

  }

  void initializeAnimations() {

    scrollBackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

  }

  void handleAnimationStateChange() {
    if (animationState.shouldRunScrollBackAnimation) {
      executeScrollBackAnimation();
    }
  }

  void executeScrollBackAnimation() {
    scrollBackController.reset();
    scrollBackController.forward();
  }

  
  late bool showClues = false;

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
          bb = bb + "${letters[i]} ";
        } else {
          bb = bb + "- ";
        }
      }
      res = bb;
    }
    return res;
  }

  double getSwipeOpacity(GamePlayState gamePlayState, int key) {
    double res = 0.0;
    List<double> path = gamePlayState.clueSwipePath;
    
    if (path.isEmpty) {
      res = 0.0;
    } else {
      if (gamePlayState.swipedClueStartId == key) {
        double denominator = gamePlayState.tileSize*5;
        double numerator = (path[0] - path[path.length-1]);
        // if ((numerator/denominator) )
        res = (numerator/denominator).abs();
      }
    }
    return res;
  }
  List<Color> getColors(double opacity) {
    List<Color> res = [
      Colors.transparent,
      Colors.transparent,
    ];
    if (opacity != 0.0) {
      res = [
        Color.fromRGBO(231, 147, 141, opacity),
        Colors.transparent,        
      ];
    }
    return res;
  }

  List<Widget> getCluesList(GamePlayState gamePlayState) {
    List<Widget> clues = [];
    gamePlayState.words.forEach((key,value) {
      Widget widget = GestureDetector(
        onHorizontalDragStart: (details) {
          // print("starting to swipe $value");
          // print(details.localPosition.dx);
          gamePlayState.setSwipedClueStartId(key);
          gamePlayState.setClueSwipePath([...gamePlayState.clueSwipePath,details.localPosition.dx]);
        },
        onHorizontalDragUpdate: (details) {
          double dx = details.localPosition.dx;
          if (!gamePlayState.clueSwipePath.contains(dx)) {
            gamePlayState.setClueSwipePath([...gamePlayState.clueSwipePath,dx]);
          }
        },
        onHorizontalDragEnd: (details) {
          print("finishing swipe of clue $value");
          GameLogic().validateGuess(gamePlayState, value);
          gamePlayState.setClueSwipePath([]);
          gamePlayState.setSwipedClueStartId(null);
        },

        onHorizontalDragCancel: () {
          gamePlayState.setClueSwipePath([]);
          gamePlayState.setSwipedClueStartId(null);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: getColors(getSwipeOpacity(gamePlayState, key))
            )
          ),
          child: Row(
            children: [
              Container(
                width: gamePlayState.tileSize*0.45,
                child: Center(
                  child: Text(
                    "${(key+1)}.",
                    style: TextStyle(
                      fontSize: gamePlayState.tileSize*0.25
                    ),
                  )
                ),
              ),
              Container(
                width: gamePlayState.tileSize,
                child: Center(
                  child: Text(
                    // value['word']
                    hashWord(gamePlayState,key),
                    style: TextStyle(
                      fontSize: gamePlayState.tileSize*0.25
                    ),                    
          
                  ),
                ),
              ),
              SizedBox(width: 5.0,),
              Flexible(
                child: Container(
                  child: Text(
                    value["clue"],
                    style: TextStyle(
                      decoration: value["active"] ? TextDecoration.none : TextDecoration.lineThrough,
                      fontSize: gamePlayState.tileSize*0.25
                    ),
                    // overflow: TextOverflow.clip,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          ),
        ),
      );
      Widget divider = Divider(
        thickness:1.0,
        color: Colors.grey,
      );

      clues.add(widget);
      clues.add(divider);
    });
    return clues;
  }


  // List<Widget> getWordKeys(GamePlayState gamePlayState) {
  //   List<Widget> items = [];
  //   gamePlayState.words.forEach((key,value) {
  //     Widget widget = Container(
  //       width: gamePlayState.tileSize*0.65,
  //       height: gamePlayState.tileSize*0.65,
  //       child: Center(
  //         child: Container(
  //           width: gamePlayState.tileSize*0.6,
  //           height: gamePlayState.tileSize*0.6,
  //           decoration: BoxDecoration(
  //             color: value["active"] ? Colors.blue : Colors.orange,
  //             borderRadius: BorderRadius.circular(100.0)
  //           ),
  //           child: Draggable(
  //             data: value,
  //             feedback: Container(
  //               width: gamePlayState.tileSize*0.5,
  //               height: gamePlayState.tileSize*0.5,
  //               color: Colors.purple,
  //             ),
  //             childWhenDragging: Container(
  //               width: gamePlayState.tileSize*0.5,
  //               height: gamePlayState.tileSize*0.5,
  //               color: Colors.green,
  //             ),
  //             // onDragUpdate: (details) {
  //             //   print(details);
  //             // },
  //             child: Center(
  //               child: Text(
  //                 (key+1).toString(),
  //                 style: TextStyle(
  //                   fontSize: gamePlayState.tileSize*0.25,
  //                   color: Colors.black
  //                 ),
  //               ),
  //             ),
  //           ),
  //           // child: Center(
  //           //   child: Text(
  //           //     (key+1).toString(),
  //           //     style: TextStyle(
  //           //       fontSize: gamePlayState.tileSize*0.25,
  //           //       color: Colors.black
  //           //     ),
  //           //   ),
  //           // ),
  //         ),
  //       ),
  //     );
  //     items.add(widget);
  //   });

  //   return items;
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        Helpers().getUnHashedLetters(gamePlayState);
        late AnimationState _animationState = Provider.of<AnimationState>(context, listen: false);
        late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
        double ts = gamePlayState.tileSize;
        return Stack(
          children: [
            Container(
              width: settingsState.screenSizeData["width"],
              height: settingsState.screenSizeData["height"],
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 202, 149, 211),
                    Colors.white,
                    Color.fromARGB(255, 253, 245, 170),
                  ]
                )
              ),
            ),
            Positioned(
              top: gamePlayState.tileSize*2,
              left: gamePlayState.tileSize*2,
              child: Container(
                width: gamePlayState.tileSize,
                height: gamePlayState.tileSize,
                color: Colors.orange.withOpacity(0.5)
              )
            ),
  
            Positioned(
              top: gamePlayState.tileSize*4,
              left: gamePlayState.tileSize*3,
              child: Container(
                width: gamePlayState.tileSize,
                height: gamePlayState.tileSize,
                color: Colors.orange.withOpacity(0.5)
              )
            ),

            Positioned(
              top: gamePlayState.tileSize*3,
              left: gamePlayState.tileSize*5,
              child: Container(
                width: gamePlayState.tileSize,
                height: gamePlayState.tileSize,
                color: Colors.orange.withOpacity(0.5)
              )
            ),                        
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Main Menu"),
                        onTap: () {
                          // Helpers().navigateToMainMenu(context);
                          print("menu");
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Restart"),
                        onTap: () {
                          print("restart");
                        },
                      ),
                    ]
                  )                  
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Container(
                      width: gamePlayState.tileSize*5.5,
                      height: settingsState.screenSizeData["topWidgetHeight"],
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: gamePlayState.tileSize,
                            height: gamePlayState.tileSize*0.7,
                            color: Colors.blue,
                          ),
                          Container(
                            width: gamePlayState.tileSize,
                            height: gamePlayState.tileSize*0.7,
                            color: Colors.blue,
                          ),                          
                        ],
                      )
                    ),                    
                    
                    // Container(
                    //   width: gamePlayState.tileSize*5.5,
                    //   height: gamePlayState.tileSize*0.7,
                    //   child: Center(
                    //     child: Text(
                    //       "Clues",
                    //       style: TextStyle(
                    //         fontSize: gamePlayState.tileSize*0.5,
                    //         color: Colors.black
                    //       )
                    //     )
                    //   ),
                    // ),
              
                    Stack(
                      children: [
                        // Container(
                        //   width: gamePlayState.tileSize*5.5,
                        //   height: gamePlayState.tileSize*6,
                        //   // color: Colors.blue,
                        //   child: BackdropFilter(
                        //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.all(Radius.circular(ts*0.2)),
                        //         color: const Color.fromARGB(255, 219, 217, 217).withOpacity(0.5),
                        //       ),
                        //     ),
                        //   ),                          
                        // ),
                        Container(
                          width: gamePlayState.tileSize*5.5,
                          height: settingsState.screenSizeData["cluesWidgetHeight"],
                          decoration: BoxDecoration(
                            color: Color.fromARGB(118, 223, 222, 222),
                            borderRadius: BorderRadius.all(Radius.circular(ts*0.2))
                        
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: getCluesList(gamePlayState)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: gamePlayState.tileSize*0.25,),
                    Container(
                      width: gamePlayState.tileSize*5.5,
                      height: settingsState.screenSizeData["lockWidgetHeight"],
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,                      
                        children: [
                          Container(
                            width: gamePlayState.tileSize*5.5,
                            height: settingsState.screenSizeData["lockWidgetHeight"]*0.8,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black, width: ts*0.01),
                              borderRadius: BorderRadius.all(Radius.circular(ts*0.15)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color.fromARGB(255, 73, 73, 73),
                                  Color.fromARGB(255, 50, 50, 51)
                                ]
                              )
                            ),
                            child: Center(
                              child: Container(
                                width: gamePlayState.tileSize*5,
                                child: GestureDetector(
                                  onPanStart:(details) {
                                    double wheel = (details.localPosition.dx / gamePlayState.tileSize);
                                    double leftOver = (details.localPosition.dx % gamePlayState.tileSize)/gamePlayState.tileSize;
                                    int? index = (wheel - leftOver).round();
                                    gamePlayState.setDragStartWheelId(index);
                                  },
                                
                                  onPanUpdate: (details) {
                                    if (gamePlayState.dragStartWheelId != null) {
                                      late Offset coords = Offset(details.localPosition.dx,details.localPosition.dy);
                                      late List<Offset> currentPath = gamePlayState.dragPath;
                                      gamePlayState.setDragPath([...currentPath,coords]);
                                      late Offset firstCoords = gamePlayState.dragPath[0];
                                
                                      late double yDistance = (firstCoords.dy - coords.dy);
                                
                                      if (yDistance >= gamePlayState.tileSize) {
                                        GameLogic().executeMoveUp(gamePlayState);
                                        gamePlayState.setDragStartWheelId(null);
                                        gamePlayState.setDragPath([]);
                                      } 
                                
                                      if (yDistance <= (gamePlayState.tileSize*-1) ) {
                                        GameLogic().executeMoveDown(gamePlayState);
                                        gamePlayState.setDragStartWheelId(null);
                                        gamePlayState.setDragPath([]);
                                      }                       
                                    }
                                  },
                                
                                  onPanEnd: (details) {
                                    late Offset coords = Offset(details.localPosition.dx,details.localPosition.dy);
                                    late List<Offset> currentPath = gamePlayState.dragPath;
                                    gamePlayState.setDragPath([...currentPath,coords]);
                                    late Offset firstCoords = gamePlayState.dragPath[0];
                                
                                    late double yDistance = (firstCoords.dy - coords.dy);
                                    if (yDistance >0 && yDistance <= gamePlayState.tileSize) {
                                      print("tried to swipe up but didn't quite make it");
                                      _animationState.setShouldRunScrollBackAnimation(true);
                                
                                
                                    } 
                                
                                
                                    if (yDistance<0 && yDistance >= (gamePlayState.tileSize*-1) ) {
                                      print("tried to swipe down but didn't quite make it");
                                      _animationState.setShouldRunScrollBackAnimation(true);
                                      
                                    }                        
                                
                                
                                
                                    Future.delayed(const Duration(milliseconds: 200), () {
                                      _animationState.setShouldRunScrollBackAnimation(false);
                                      gamePlayState.setDragStartWheelId(null);
                                      gamePlayState.setDragPath([]);
                                    });
                                
                                  },
                                
                                  child: Row(
                                    children: [
                                      DialWidget(index: 0, scrollBackController: scrollBackController,),
                                      DialWidget(index: 1, scrollBackController: scrollBackController,),
                                      DialWidget(index: 2, scrollBackController: scrollBackController,),
                                      DialWidget(index: 3, scrollBackController: scrollBackController,),
                                      DialWidget(index: 4, scrollBackController: scrollBackController,),                                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}


