import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/screens/game_screen/components/dial_letter.dart';
import 'package:provider/provider.dart';

class DialWidget extends StatefulWidget {
  final int index;
  final AnimationController scrollBackController;
  const DialWidget({
    super.key,
    required this.index,
    required this.scrollBackController,
  });

  @override
  State<DialWidget> createState() => _DialWidgetState();
}

class _DialWidgetState extends State<DialWidget> with SingleTickerProviderStateMixin{


  late Animation<double> scrollBackAnimation;

  // late Animation<double> scrollBackAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAnimations();
  }

  void initializeAnimations() {
    scrollBackAnimation = Tween(begin:1.0,end: 0.0).animate(widget.scrollBackController);
  }


  List<Widget> getDialLetters(AnimationState animationState, GamePlayState gamePlayState, Animation<double> anim) {
    List<Widget> res = [];

    late double ts = gamePlayState.tileSize;
    late double distanceY = Helpers().getDistanceY(gamePlayState);
    late bool isTarget = Helpers().getIsTarget(gamePlayState, widget.index);
    late List<String> wheelData = gamePlayState.wheelData[widget.index];

    if (animationState.shouldRunScrollBackAnimation) {

      Widget dialWidget0 = AnimatedBuilder(
        animation: widget.scrollBackController,
        builder: (context,child) {
          return DialLetter(
            offset: Offset(0,Helpers().getUpperPiece2Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2),),
            angle: Helpers().getUpperPiece2Angle((distanceY*anim.value), ts,isTarget),
            tileSize: ts, 
            border: Helpers().getUpperPiece2Border((distanceY*anim.value),ts,isTarget), 
            body: wheelData[0],
            scrollBackController: widget.scrollBackController,
          );
        }
      );      
      Widget dialWidget1 = AnimatedBuilder(
        animation: widget.scrollBackController,
        builder: (context,child) {
          return DialLetter(
            offset: Offset(0,Helpers().getUpperPiece1Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2)),
            angle: Helpers().getUpperPiece1Angle((distanceY*anim.value), ts,isTarget),
            tileSize: ts, 
            border: Helpers().getUpperPiece1Border((distanceY*anim.value),ts,isTarget), 
            body: wheelData[1],
            scrollBackController: widget.scrollBackController,
          );
        }
      );
      Widget dialWidget2 = AnimatedBuilder(
        animation: widget.scrollBackController,
        builder: (context,child) {
          return DialLetter(
            offset: Offset(0, (Helpers().getYOffset((distanceY*anim.value),isTarget)+(((ts*2.5)-ts)/2))),
            angle: Helpers().getCenterPieceAngle((distanceY*anim.value), ts,isTarget),
            tileSize: ts, 
            border: Helpers().getCenterPieceBorder((distanceY*anim.value),ts,isTarget),
            body: wheelData[2],
            scrollBackController: widget.scrollBackController,
          );
        }
      ); 

      Widget dialWidget3 = AnimatedBuilder(
        animation: widget.scrollBackController,
        builder: (context,child) {
          return DialLetter(
            offset: Offset(0,Helpers().getLowerPiece1Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2),),
            angle: Helpers().getLowerPiece1Angle((distanceY*anim.value), ts,isTarget),
            tileSize: ts, 
            border: Helpers().getLowerPiece1Border((distanceY*anim.value),ts,isTarget), 
            body: wheelData[3],
            scrollBackController: widget.scrollBackController,
          );
        }
      ); 

      Widget dialWidget4 = AnimatedBuilder(
        animation: widget.scrollBackController,
        builder: (context,child) {
          return DialLetter(
            offset: Offset(0,Helpers().getLowerPiece2Offset((distanceY*anim.value),ts,isTarget)+(((ts*2.5)-ts)/2),),
            angle: Helpers().getLowerPiece2Angle((distanceY*anim.value), ts,isTarget),
            tileSize: ts, 
            border: Helpers().getLowerPiece2Border((distanceY*anim.value),ts,isTarget), 
            body: wheelData[4],
            scrollBackController: widget.scrollBackController,
          );
        }
      );             


      res.add(dialWidget0);
      res.add(dialWidget1);
      res.add(dialWidget2);
      res.add(dialWidget3);
      res.add(dialWidget4);


    } else {

      Widget dialLetter0 = DialLetter(
        offset: Offset(0,Helpers().getUpperPiece2Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2),),
        angle: Helpers().getUpperPiece2Angle(distanceY, ts,isTarget),
        tileSize: ts, 
        border: Helpers().getUpperPiece2Border(distanceY,ts,isTarget), 
        body: wheelData[0],
        scrollBackController: widget.scrollBackController,
      );
  

      Widget dialLetter1 = DialLetter(
        offset: Offset(0,Helpers().getUpperPiece1Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2)),
        angle: Helpers().getUpperPiece1Angle(distanceY, ts,isTarget),
        tileSize: ts, 
        border: Helpers().getUpperPiece1Border(distanceY,ts,isTarget), 
        body: wheelData[1],
        scrollBackController: widget.scrollBackController,
      );

      Widget dialLetter2 = DialLetter(
        offset: Offset(0,Helpers().getYOffset(distanceY,isTarget)+(((ts*2.5)-ts)/2),), 
        angle: Helpers().getCenterPieceAngle(distanceY, ts,isTarget),
        tileSize: ts, 
        border: Helpers().getCenterPieceBorder(distanceY,ts,isTarget), 
        body: wheelData[2],
        scrollBackController: widget.scrollBackController,
      );


      Widget dialLetter3 = DialLetter(
        offset: Offset(0,Helpers().getLowerPiece1Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2),),
        angle: Helpers().getLowerPiece1Angle(distanceY, ts,isTarget),
        tileSize: ts, 
        border: Helpers().getLowerPiece1Border(distanceY,ts,isTarget), 
        body: wheelData[3],
        scrollBackController: widget.scrollBackController,
      );

      Widget dialLetter4 = DialLetter(
        offset: Offset(0,Helpers().getLowerPiece2Offset(distanceY,ts,isTarget)+(((ts*2.5)-ts)/2),),
        angle: Helpers().getLowerPiece2Angle(distanceY, ts,isTarget),
        tileSize: ts, 
        border: Helpers().getLowerPiece2Border(distanceY,ts,isTarget), 
        body: wheelData[4],
        scrollBackController: widget.scrollBackController,
      ); 
      res.add(dialLetter0);
      res.add(dialLetter1);
      res.add(dialLetter2);
      res.add(dialLetter3);
      res.add(dialLetter4);
    }

    return res;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationState>(
      builder: (context,animationState,child) {
        return Consumer<GamePlayState>(
          builder: (context,gamePlayState,child) {
            late double ts = gamePlayState.tileSize;
            late double distanceY = Helpers().getDistanceY(gamePlayState);
            late bool isTarget = Helpers().getIsTarget(gamePlayState, widget.index);
            late List<String> wheelData = gamePlayState.wheelData[widget.index];
        
            return Container(
              width: gamePlayState.tileSize,
              height: gamePlayState.tileSize*2.5,
              
              // color: getRandomColor(),
              // color: Colors.blue,
              child: Stack(
                children: getDialLetters(animationState, gamePlayState,scrollBackAnimation),
              ),
            );
          }
        );
      }
    );
  }
}

