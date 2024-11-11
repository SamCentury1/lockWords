import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lock_words/ads/ad_mob_service.dart';
import 'package:lock_words/functions/game_logic.dart';
import 'package:lock_words/functions/helpers.dart';
import 'package:lock_words/providers/ad_state.dart';
import 'package:lock_words/providers/animation_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/firestore_methods.dart';
import 'package:lock_words/screens/game_screen/components/app_bar/app_bar.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/clue_summary_widget.dart';
import 'package:lock_words/screens/game_screen/components/clues/clues_widget.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/cryptex_widget.dart';
import 'package:lock_words/screens/game_screen/components/cryptex/dial_widget.dart';
import 'package:lock_words/screens/game_screen/components/decorations/background.dart';
import 'package:lock_words/screens/game_screen/components/decorations/coin_animation_painter.dart';
import 'package:lock_words/screens/game_screen/components/decorations/coin_value_change_widget.dart';
import 'package:lock_words/screens/game_screen/components/drawer/drawer_widget.dart';
import 'package:lock_words/screens/game_screen/components/game_summary_overlay/game_summary_overlay_widget.dart';
import 'package:lock_words/screens/game_screen/components/word_found_overlay/word_found_overlay_painter.dart';
import 'package:lock_words/screens/game_screen/components/word_found_overlay/word_found_overlay_widget.dart';
import 'package:lock_words/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {

  late double horizontalDragValue = 0.0;
  late double localPosX = 0.0;
  late AnimationState animationState;
  
  // late ScrollController scrollCluesController;
  late ItemScrollController itemScrollController;

  // late AnimationController colorController;
  // late Animation<Color?> colorAnimation;
  late bool lockPressed = false;

  late AnimationController _quarterTurnController;
  late Animation<double> _quarterTurnAnimation;

  late AnimationController _fullTurnController;
  late Animation<double> _fullTurnAnimation;  

  late AnimationController _foundWordOverlayController;
  late Animation<double> _foundWordOverlayAnimation;  

  // late AnimationController _foundWordProgressController;
  late Animation<double> _foundWordProgressAnimation;

  late AnimationController showClueController;
  late AnimationController hideClueController;
  // late AnimationController _flipClueCardInAngleController;
  late Animation<double> showAngleAnimation;

  // late AnimationController _flipClueCardOutAngleController;
  late Animation<double> hideAngleAnimation;

  // late AnimationController _flipClueCardInVisibilityController;
  late Animation<double> showInVisibilityAnimation;
  late Animation<double> showOutVisibilityAnimation;
  // late AnimationController _flipClueCardOutVisibilityController;
  late Animation<double> hideInVisibilityAnimation;
  late Animation<double> hideOutVisibilityAnimation;

  late Animation<double> showProgressAnimation;
  late Animation<double> hideProgressAnimation;

  late AnimationController coinProgressController;
  // late Animation<double> coinProgressAnimation;

  late Animation<double> overlayWordGlowAnimation;

  // WHEN A HINT IS CHARGED
  late Animation<double> hintChargePositionAnimation;
  late Animation<double> hintChargeVisibilityAnimation;

    

  late List<Offset> sparks = [];
  // late List<Map<String,dynamic>> sparks2 = [];

  late Map<dynamic,dynamic> coinAnimationOffsets = {};
  late Map<dynamic,dynamic> pathData = {}; 

  // RewardedAd? _rewardedAd;
  late AdState _adState;
  // late GamePlayState _gamePlayState;



  
  // late double _screenWidth = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _adState = Provider.of<AdState>(context, listen: false);


    initializeAnimations();

    animationState = Provider.of<AnimationState>(context,listen: false);
    animationState.addListener(handleAnimationStateChanges);
    itemScrollController = ItemScrollController();


    // _createRewardedAd();
    _adState.createRewardedAd();
  }


  void initializeAnimations() {

      _quarterTurnController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      List<TweenSequenceItem<double>> _quarterTurnAnimationSequence = [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 90,), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 90.0, end: 0.0,), weight: 50),
      ];

      _quarterTurnAnimation  = TweenSequence<double>(_quarterTurnAnimationSequence).animate(_quarterTurnController);

      _fullTurnController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );

      List<TweenSequenceItem<double>> _fullTurnAnimationSequence = [
        TweenSequenceItem(tween: Tween(begin: 0.00, end: 360.00,), weight: 100),
        // TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00,), weight: 1),
      ];      

      _fullTurnAnimation  = TweenSequence<double>(_fullTurnAnimationSequence).animate(_fullTurnController);


      _foundWordOverlayController = AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this,
      );

      List<TweenSequenceItem<double>> foundWordOverlayAnimationSequence = [
        TweenSequenceItem(tween: Tween(begin: 0.00, end: 1.00,), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00,), weight: 80),
        TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.00,), weight: 10),
      ];      

      _foundWordOverlayAnimation  = TweenSequence<double>(foundWordOverlayAnimationSequence).animate(_foundWordOverlayController); 

      List<TweenSequenceItem<double>> overlayWordGlowAnimationSequence = [
        TweenSequenceItem(tween: Tween(begin: 0.00, end: 1.00,), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.50,), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 0.50, end: 1.00,), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.50,), weight: 10),
        TweenSequenceItem(tween: Tween(begin: 0.50, end: 1.00,), weight: 10), 
        TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.00,), weight: 50),
      ];      

      overlayWordGlowAnimation  = TweenSequence<double>(overlayWordGlowAnimationSequence).animate(_foundWordOverlayController);            

      List<TweenSequenceItem<double>> foundWordProgressAnimationSequence = [
        TweenSequenceItem(tween: Tween(begin: 0.00, end: (600)-1), weight: 100),
      ];      

      _foundWordProgressAnimation  = TweenSequence<double>(foundWordProgressAnimationSequence).animate(_foundWordOverlayController);      

    /// ========= SHOW ===================
    showClueController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    showProgressAnimation =Tween<double>(begin: 0.00, end: 1.0).animate(showClueController);  

    CurvedAnimation showCurvedAnimation = CurvedAnimation(parent: showClueController, curve: Curves.linear);
    showAngleAnimation  = Tween<double>(begin: 0.00, end: 180.0).animate(showCurvedAnimation);  

    List<TweenSequenceItem<double>> showInVisibilitySequence = [
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 1.00), weight: 05),
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00), weight: 40),
    ];      
    showInVisibilityAnimation  = TweenSequence<double>(showInVisibilitySequence).animate(showClueController);

    List<TweenSequenceItem<double>> showOutVisibilitySequence = [
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.00), weight: 05),
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00), weight: 55),
    ];      
    showOutVisibilityAnimation  = TweenSequence<double>(showOutVisibilitySequence).animate(showClueController);    

    /// ========= HIDE ===================
    hideClueController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    hideProgressAnimation =Tween<double>(begin: 1.00, end: 0.00).animate(hideClueController);  
    List<TweenSequenceItem<double>> hideAngleSequence = [
      TweenSequenceItem(tween: Tween(begin: 180.00, end: 0.0), weight: 10),
    ];
    // CurvedAnimation hideCurvedAnimation = CurvedAnimation(parent: showClueController, curve: Curves.easeIn);

    hideAngleAnimation  = TweenSequence<double>(hideAngleSequence).animate(hideClueController);   

    List<TweenSequenceItem<double>> hideInVisibilitySequence = [
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.00), weight: 05),
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00), weight: 55),
  
    ];      
    hideInVisibilityAnimation  = TweenSequence<double>(hideInVisibilitySequence).animate(hideClueController);

    List<TweenSequenceItem<double>> hideOutVisibilitySequence = [
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 0.00), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 1.00), weight: 05),
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00), weight: 40),
  
    ];      
    hideOutVisibilityAnimation  = TweenSequence<double>(hideOutVisibilitySequence).animate(hideClueController);


    coinProgressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );     
    hintChargePositionAnimation =Tween<double>(begin: 0.0, end: 1.0).animate(coinProgressController);

    List<TweenSequenceItem<double>> hintChargeVisibilitySequence = [
      TweenSequenceItem(tween: Tween(begin: 0.00, end: 1.00), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 1.00), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.00, end: 0.00), weight: 30),
    ];     
    hintChargeVisibilityAnimation = TweenSequence<double>(hintChargeVisibilitySequence).animate(coinProgressController);
  }

  void handleAnimationStateChanges() {
    if (animationState.shouldRunWordFoundAnimation) {
      executeFoundWordAnimation();
    }

    if (animationState.shouldRunLockQuarterTurn) {
      executeQuarterTurnAnimation();
    }

    if (animationState.shouldRunShowHintAnimation) {
      executeShowClueAnimation();
    }

    if (animationState.shouldRunHideHintAnimation) {
      executeHideClueAnimation();
    }

    if (animationState.shouldRunCoinAnimation) {
      executeCoinAnimation();

    }
  }

  void executeShowClueAnimation() {
    showClueController.reset();
    showClueController.forward();
  }

  void executeHideClueAnimation() {
    hideClueController.reset();
    hideClueController.forward();
  }  


  void executeFoundWordAnimation() {
    print("execute word found animation");
    _foundWordOverlayController.reset();
    _foundWordOverlayController.forward();
    _fullTurnController.reset();
    _fullTurnController.forward();    
  }

  void executeQuarterTurnAnimation() {
    _quarterTurnController.reset();
    _quarterTurnController.forward();
  }

  void executeCoinAnimation() {
    coinProgressController.reset();
    coinProgressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationState>(
      builder: (context,_animationState,child) {
        return Consumer<GamePlayState>(
          builder: (context,gamePlayState,child) {
            Helpers().getUnHashedLetters(gamePlayState);
            late SettingsState settingsState = Provider.of<SettingsState>(context, listen: false);
            late ColorPalette palette = Provider.of<ColorPalette>(context, listen: false);
            late Map<String,AnimationController> hintControllers = {"show": showClueController, "hide": hideClueController};
            final Map<String,dynamic> hintAnimations = {
              "show": {
                "angle": showAngleAnimation,
                "inVisibility": showInVisibilityAnimation,
                "outVisibility": showOutVisibilityAnimation,
                "progress": showProgressAnimation,
              },
              "hide": {
                "angle": hideAngleAnimation,
                "inVisibility": hideInVisibilityAnimation,
                "outVisibility": hideOutVisibilityAnimation,
                "progress": hideProgressAnimation
              }
            };

            

            return Stack(
              children: [
                SizedBox(
                  width: settingsState.screenSizeData["width"],
                  height: settingsState.screenSizeData["height"],
                  child: CustomPaint(painter: Background(palette: palette),),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: PreferredSize(
                    preferredSize: ui.Size(MediaQuery.of(context).size.width, 40.0),
                    child: const AppBarWidget(),
                  ),


                  drawer: const DrawerWidget(),
                  body: Stack(
                    children: [


                      CluesWidget(
                        itemScrollController: itemScrollController,
                        hintControllers: hintControllers,
                        hintAnimations: hintAnimations, 
                      ),

                      CryptexWidget(
                        itemScrollController: itemScrollController, 
                        foundWordController: _foundWordOverlayController,
                        quarterTurnController: _quarterTurnController,
                        quarterTurnAnimation: _quarterTurnAnimation, 
                        fullTurnAnimation: _fullTurnAnimation
                      )
                    ],
                  ),
                ),

                WordFoundOverlayWidget(
                  foundWordController: _foundWordOverlayController, 
                  foundWordOverlayAnimation: _foundWordOverlayAnimation, 
                  foundWordProgressAnimation: _foundWordProgressAnimation, 
                  overlayWordGlowAnimation: overlayWordGlowAnimation,
                ),

                AnimatedBuilder(
                  animation: coinProgressController,
                  builder: (context, child) {
                    late double itemWidth = 40;
                    late double itemHeight = 40;

                    if (animationState.shouldRunCoinAnimation && gamePlayState.clueTappedPosition != null) {
                      double top = gamePlayState.clueTappedPosition!.dy - (itemHeight/2) - (hintChargePositionAnimation.value * (itemHeight*2));
                      double left = gamePlayState.clueTappedPosition!.dx - (itemWidth/2); 
                      return Positioned(
                        top: top,
                        left: left,
                        child: Container(
                          width: itemWidth,
                          height: itemHeight,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 28,
                              color: palette.mainTextColor.withOpacity(hintChargeVisibilityAnimation.value),
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  offset: Offset.zero,
                                  color: palette.mainTextColor
                                )
                              ]
                            ),
                            child: Text("-10"),
                          ),
                          // color: Colors.red.withOpacity(hintChargeVisibilityAnimation.value),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }
                ),
                const GameSummaryOverlayWidget()                
              ],
            );
          }
        );
      }
    );
  }
}