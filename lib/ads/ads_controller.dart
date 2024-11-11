import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lock_words/ads/preloaded_banner_ad.dart';

class AdsController {
  final MobileAds _instance;

  // PreloadedBannerAd? _preloadedBannerAd;

  AdsController(MobileAds instance) : _instance = instance;

  // void dispose() {
  //   // _preloadedBannerAd?.dispose();
  //   super.dispose();
  // }

  Future<void> initialize() async {
    await _instance.initialize();
  }

  // void preloadBannerAd() {
  //   final adUnitId = defaultTargetPlatform == TargetPlatform.android

  //       // DEVELOPMENT 
  //       ? 'ca-app-pub-3940256099942544/6300978111' // SAMPLE ANDROID BANNER AD ID
  //       : 'ca-app-pub-3940256099942544/2934735716'; // SAMPLE IOS BANNER AD ID

  //       // // PRODUCTION 
  //       // ? 'ca-app-pub-2459167095237263/8303846130'
  //       // : ''

  //   // _preloadedBannerAd = PreloadedBannerAd(size: AdSize.mediumRectangle, adUnitId: adUnitId);

  //   Future<void>.delayed(const Duration(seconds: 1)).then((_) {
  //     // return _preloadedBannerAd!.load();
  //   });
  // }

  // PreloadedBannerAd? takePreloadedAd() {
  //   final ad = _preloadedBannerAd;
  //   _preloadedBannerAd = null;
  //   return ad;
  // }  

}

