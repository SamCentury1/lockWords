import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lock_words/ads/ad_mob_service.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/auth_service.dart';
import 'package:lock_words/resources/firestore_methods.dart';

class AdState extends ChangeNotifier {



  late RewardedAd? _rewardedAd = null;
  RewardedAd? get rewardedAd => _rewardedAd;
  void setRewardedAd(RewardedAd? value) {
    _rewardedAd = value;
    notifyListeners();
  }

  AdState() {
    createRewardedAd();
  }  

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUnitId!, 
      request: const AdRequest(), 
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          debugPrint("ad loaded : ${ad}");
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          debugPrint("error loading ad : ${error}");
        }
      ),
    );
  }

  void showRewardedAd(BuildContext context, SettingsState settingsState) {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createRewardedAd();
          // gamePlayState.startTimer();
        },
        onAdFailedToShowFullScreenContent: (ad,error) {
          ad.dispose();
          createRewardedAd();
        }
      );

      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          final Map<dynamic,dynamic> userData = settingsState.userData;
          final int balance = userData["balance"];
          final int newBalance = balance + 30;
          userData.update("balance", (v) => newBalance);
          FirestoreMethods().updateBalance(userData["uid"], newBalance);
          Navigator.of(context).pop();
        },
      );
      createRewardedAd();
      _rewardedAd = null;
    }
  }
  

  void showRewardedAdInGame(GamePlayState gamePlayState) {
    // Navigator.of(context).pop();
    gamePlayState.timer.cancel();
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createRewardedAd();
          gamePlayState.startTimer();
        },
        onAdFailedToShowFullScreenContent: (ad,error) {
          ad.dispose();
          createRewardedAd();
        }
      );

      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          gamePlayState.setCoins(gamePlayState.coins+100);
        },
      );
      _rewardedAd = null;
    }

  }



}