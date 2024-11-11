import 'package:flutter/material.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/screens/game_screen/components/app_bar/coin.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  // final AnimationController coinController;
  const AppBarWidget({
    super.key,
    // required this.coinController,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> with SingleTickerProviderStateMixin {


  late Animation<double> coinSizeAnimation;
  late Animation<double> coinRippleAnimation;

  late AnimationController scoreBoardScaleController;
  late Animation<double> scoreBoardScaleAnimation;

  late AnimationState _animationState;

  late bool light = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationState = Provider.of<AnimationState>(context, listen: false);
    scoreBoardScaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    List<TweenSequenceItem<double>> scoreBoardScaleAnimationSequence = [
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.0), weight: 50),           
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
    ];      
    scoreBoardScaleAnimation  = TweenSequence<double>(scoreBoardScaleAnimationSequence).animate(scoreBoardScaleController);


    _animationState.addListener(handleAnimationStateChanges);

  }

  void handleAnimationStateChanges() {
    if (_animationState.shouldRunScoreCountAnimation) {
      // scoreBoardScaleController.reset();
      scoreBoardScaleController.reset();
      scoreBoardScaleController.forward();
    } else {
      scoreBoardScaleController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
    return Consumer<GamePlayState>(
      builder: (context,gamePlayState,child) {
        final String level = gamePlayState.level;
        return AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: palette.mainTextColor),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                level,
                style: TextStyle(
                  color: palette.mainTextColor
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  AnimatedBuilder(
                    animation: scoreBoardScaleController,
                    builder: (context,child) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(width: 1.0 + (1.0 * scoreBoardScaleAnimation.value) ,color: palette.mainTextColor),
                  
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6.0,3.0,6.0,3.0),
                          child: Text(
                            gamePlayState.score.toString(),
                            style: TextStyle(
                              color:  palette.mainTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2.0,
                              shadows: [
                                // Shadow(
                                //   color: palette.mainTextColor,
                                //   offset: Offset.zero,
                                //   blurRadius: 10.0 * scoreBoardScaleAnimation.value,
                                // ),
                                Shadow(
                                  color: palette.mainTextColor,
                                  offset: Offset.zero,
                                  blurRadius: 25.0 * scoreBoardScaleAnimation.value,
                                ),
                                // Shadow(
                                //   color: palette.mainTextColor,
                                //   offset: Offset.zero,
                                //   blurRadius: 35.0 * scoreBoardScaleAnimation.value,
                                // )                                
                              ]
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),              
            ],
          ),
          // actions: [
          //   PopupMenuButton<int>(
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         child: Text("Main Menu"),
          //         onTap: () {
          //           gamePlayState.quitGame();
          //           Navigator.pushAndRemoveUntil<void>(
          //             context,
          //             MaterialPageRoute<void>(builder: (BuildContext context) => const HomeScreen()),
          //             ModalRoute.withName('/home'),
          //           );
          //         },
          //       ),
          //       PopupMenuItem(
          //         child: Text("Restart"),
          //         onTap: () {
          //           print("restart");
          //         },
          //       ),
          //       PopupMenuItem(
          //         child: StatefulBuilder(
          //           builder: (BuildContext context, StateSetter setState) {
          //             return Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 gamePlayState.isLockOnLeft ? Text("Lock Side (Right)") : Text("Lock Side (Left)"),
          //                 Transform.scale(
          //                   scale: 0.7,  // Adjust the scale as needed
          //                   child: Switch(
          //                     value: gamePlayState.isLockOnLeft,
          //                     // activeColor: Colors.red,
          //                     // inactiveTrackColor: Colors.green,
          //                     // activeColor:Colors.white,
          //                     trackColor: MaterialStateProperty.all(Colors.black),
          //                     onChanged: (bool value) {
          //                       setState(() {
          //                         gamePlayState.setIsLockOnLeft(value);
          //                       });
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //     onSelected: (_) {},
          //     onCanceled: () {},
          //   ),          
          // ],
        );
      }
    );
  }
}

