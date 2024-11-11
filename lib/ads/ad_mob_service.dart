import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {

  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {   
      return 'ca-app-pub-3940256099942544/6300978111'; /// DEVELOPMENT
      // return 'ca-app-pub-2459167095237263/8303846130'; /// PRODUCTION
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; /// DEVELOPMENT
      // return ''; /// PRODUCTION
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('ad loaded'),
    onAdFailedToLoad: (ad,error) {
      ad.dispose();
      debugPrint("ad failed to load: => ${error.toString()}");
    },
    onAdOpened: (ad) => debugPrint("ad opened"),
    onAdClicked: (ad) => debugPrint("ad clicked"),
    onAdClosed: (ad) => debugPrint("ad closed"),
  );



  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';  /// DEVELOPMENT
      // return 'ca-app-pub-2459167095237263/5617541841';  /// PRODUCTION
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }  




  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; /// DEVELOPMENT
      // return 'ca-app-pub-2459167095237263/8331205214'; /// PRODUCTION 
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }    
}




