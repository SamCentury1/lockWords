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
  final Map<String,AnimationController> hintControllers;
  final Map<dynamic,dynamic> hintAnimations;
  const CluesWidget({
    super.key,
    required this.itemScrollController,
    required this.hintControllers,
    required this.hintAnimations,
  });

  @override
  State<CluesWidget> createState() => _CluesWidgetState();
}

class _CluesWidgetState extends State<CluesWidget> {

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
                    physics: ClampingScrollPhysics(),
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
  List<Widget> res = [];
  for (int i=0; i<gamePlayState.words.length; i++) {
    Widget widget = ClueWidget(index: i,);
    res.add(widget);    
  }
  return res;
}