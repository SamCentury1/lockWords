// import 'dart:async';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class PreloadedBannerAd {
//   final AdSize size;

//   final AdRequest _adRequest;
  

//   BannerAd? _bannerAd;

//   final String adUnitId;

//   final _adCompleter = Completer<BannerAd>();

//   PreloadedBannerAd({
//     required this.size,
//     required this.adUnitId,
//     AdRequest? adRequest,
//   }) : _adRequest = adRequest ?? const AdRequest();


//   Future<BannerAd> get ready => _adCompleter.future;

//   Future<void> load() {
//     _bannerAd = BannerAd(
//       size: size,
//       adUnitId: adUnitId,
//       request: _adRequest,
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           _adCompleter.complete(_bannerAd);
//         },
//         onAdFailedToLoad: (ad,error) {
//           _adCompleter.completeError(error);
//           ad.dispose();
//         }
//       )
//     );
//     return _bannerAd!.load();
//   }

//   void dispose() {
//     _bannerAd?.dispose();
//   }
// }