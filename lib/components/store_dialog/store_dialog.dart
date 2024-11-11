import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/components/store_dialog/store_item_widget.dart';
import 'package:lock_words/providers/ad_state.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/game_screen/components/drawer/components/open_reward_dialog.dart';
import 'package:provider/provider.dart';

class StoreDialog extends StatefulWidget {
  const StoreDialog({super.key});

  @override
  State<StoreDialog> createState() => _StoreDialogState();
}

class _StoreDialogState extends State<StoreDialog> {

  late AdState _adState;
  late Future<bool> adLoadFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adState = Provider.of<AdState>(context, listen: false);
    // _adState.createRewardedAd();
    adLoadFuture = waitForAdLoad();
    
  }

  Future<bool> waitForAdLoad() async {
    // Poll the ad loading status every 100ms until loaded
    while (_adState.rewardedAd == null) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    return true;
  }



  @override
  Widget build(BuildContext context) {
  late ColorPalette palette = Provider.of<ColorPalette>(context, listen:false);
  late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
  final double sizeFactor = settingsState.screenSizeData["sizeFactor"];
  // late GamePlayState gamePlayState = Provider.of<GamePlayState>(context, listen:false);
  late AdState adState = Provider.of<AdState>(context, listen: false);


  
      return FutureBuilder(
        future: adLoadFuture,
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),); 
          } else {
            if (snapshot.data == true) {
              return Dialog(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: settingsState.screenSizeData["height"] *0.66
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0 * sizeFactor)),
                      color: palette.screenBackgroundColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0 * sizeFactor),
                          child: Text(
                            "Store",
                            style: TextStyle(
                              fontSize: 32 * sizeFactor,
                              color: palette.mainTextColor
                            ),
                          ),
                        ),
                            
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.0 * sizeFactor),
                          child: Divider(
                            thickness: 0.5,
                            color: palette.mainTextColor,
                          ),
                        ),
                          Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0 * sizeFactor),
                              child: Column(
                                children: [
    
                                  StoreItemWidget(
                                    itemData: const{"itemCount": 1, "title": "Watch Ad for 30 Coins", "type": "watchAd"}, 
                                    onTap: () {adState.showRewardedAd(context, settingsState);}
                                  ),                          
              
                                  StoreItemWidget(itemData: {"itemCount": 1, "title": "No Ads", "type": "noAds"}, onTap: (){},),
                                      
                                  StoreItemWidget(itemData: {"itemCount": 1, "title": "100 Coins", "type": "coin"}, onTap: (){},),
                                      
                                  StoreItemWidget(itemData: {"itemCount": 2, "title": "200 Coins", "type": "coin"}, onTap: (){},),
                                      
                                  StoreItemWidget(itemData: {"itemCount": 3, "title": "300 Coins", "type": "coin"}, onTap: (){},),  
                                      
                                  StoreItemWidget(itemData: {"itemCount": 4, "title": "400 Coins", "type": "coin"}, onTap: (){},),  
                                      
                                  StoreItemWidget(itemData: {"itemCount": 5, "title": "500 Coins", "type": "coin"}, onTap: (){},), 
                                      
                                  StoreItemWidget(itemData: {"itemCount": 1, "title": "1 Sapphire Gem", "type": "sapphireGem"}, onTap: (){},),  
                                      
                                  StoreItemWidget(itemData: {"itemCount": 2, "title": "2 Sapphire Gems", "type": "sapphireGem"}, onTap: (){},),  
                                      
                                  StoreItemWidget(itemData: {"itemCount": 3, "title": "3 Sapphire Gems", "type": "sapphireGem"}, onTap: (){},), 
                                      
                                  StoreItemWidget(itemData: {"itemCount": 1, "title": "1 Ruby Gem", "type": "rubyGem"}, onTap: (){},),  
                                      
                                  StoreItemWidget(itemData: {"itemCount": 2, "title": "2 Ruby Gems", "type": "rubyGem"}, onTap: (){},),  
                                      
                                  StoreItemWidget(itemData: {"itemCount": 3, "title": "3 Ruby Gems", "type": "rubyGem"}, onTap: (){},),
                                ],
                              ),
                            ),
                          ),
                        ),                               
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator(),); 
            }
          }
        }
      );
  }
}

Future<bool> getAdLoadingStatus(AdState adState) async {
  late bool res = false;
  if (adState.rewardedAd != null) {
    res = true;
  }
  return res;
}