import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lock_words/audio/audio_controller.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/auth_screen/login_or_register_screen.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:lock_words/settings/settings.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
  
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // print("Snapshot: $snapshot");
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("waiting");
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            if (snapshot.hasData) {
              

              return FutureBuilder(
                future: getScreenSizeData(context,snapshot.data), 
                builder: (context, AsyncSnapshot<void> futureSnapshot) {
                  if (futureSnapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(body: Center(child: CircularProgressIndicator()));
                  } else if (futureSnapshot.hasError) {
                    return Scaffold(body: Center(child: Text('Error: ${futureSnapshot.error}')));
                  } else {
                    return HomeScreen(); // Only return after getScreenSizeData() completes
                  }
                }
              );
              // return HomeScreen();
            }else {
              print("============================================");
              print("hm!");
              print("============================================");
              // setScreenSizeData(context);
              return LoginOrRegisterScreen();
            }
          } 
        },
      );
    
  }
}

Future<void> getScreenSizeData(BuildContext context, User? user) async {
  SettingsState settingsState = context.read<SettingsState>(); // No need for late declaration
  SettingsController settings = context.read<SettingsController>();
  ColorPalette palette = context.read<ColorPalette>();
  
  print("============================================");
  print("we are inside the getScreenSizeData function ==== ${user}");
  print("============================================");
  /// SCREEN SIZE DATA
  final double paddingTop = MediaQuery.of(context).padding.top;
  final Size size = MediaQuery.of(context).size; // Use Size instead of dynamic for clarity
  final AppBar appBar = AppBar();
  final double appBarHeight = appBar.preferredSize.height;
  // Calculate cryptex height
  final double cryptexHeight = (size.height - paddingTop - appBarHeight) * 0.3;
  final double actualCryptexHeight = cryptexHeight < 180.0 ? 180.0 : cryptexHeight;


  


  /// SET USER DATA FROM FIREBASE TO LOCAL STORAGE
  Map<String,dynamic> userData = await getFirestoreDocument(user!.uid);

  List<Map<dynamic,dynamic>> levelData = await getLevelsFromFirestore();

  // Set the screen size data directly
  WidgetsBinding.instance.addPostFrameCallback((_) {
    
    settingsState.setScreenSizeData({
      "width": size.width, 
      "height": size.height - paddingTop,  
      "cryptexHeight": actualCryptexHeight,
      "cryptexExtraWidgetWidth": size.width * 0.15,
      "cryptexTileAreaWidth": size.width * 0.7,
      "sizeFactor" : size.height < 600 ? 0.7 : 1.0,
    });

    settingsState.setUserData(userData);
    settings.setUserData(userData);
    palette.getThemeColors(userData['parameters']['theme']);
    settingsState.setLevelData(levelData);
  });
}

Future<Map<String,dynamic>> getFirestoreDocument(String uid) async {
  late DocumentSnapshot<Map<String,dynamic>> docStream;
  docStream = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  return docStream.data() as Map<String, dynamic>;
}

Future<List<Map<dynamic,dynamic>>> getLevelsFromFirestore() async {


  late QuerySnapshot gamesPlayedQuerySnapshot;
  gamesPlayedQuerySnapshot = await FirebaseFirestore.instance.collection("games")
  .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .get();


  List<Map<dynamic,dynamic>> gamesPlayed = [];
  List<String> completedLevelsIds = [];
  for (DocumentSnapshot gameDocumentSnapshot in gamesPlayedQuerySnapshot.docs) {
    late Map<dynamic,dynamic> gameData = gameDocumentSnapshot.data() as Map;
    gameData["gameId"] = gameDocumentSnapshot.id;
    gamesPlayed.add(gameData);
    completedLevelsIds.add(gameData["levelId"]);
  }


  late QuerySnapshot qSnap; 
  qSnap = await FirebaseFirestore.instance.collection("levels").orderBy("level").get();
  late List<Map<dynamic, dynamic>> levels = [];

  print(completedLevelsIds);

  for (DocumentSnapshot qDocSnap in qSnap.docs) {
    late Map<dynamic,dynamic> levelData = qDocSnap.data() as Map; // as Map<dynamic, dynamic>;
  
      // search if played game
      late Map<dynamic,dynamic> playedGameDocument = {};
      // print(qDocSnap.id);
      if (completedLevelsIds.contains(qDocSnap.id)) {
        playedGameDocument = gamesPlayed.firstWhere((value) => value["levelId"] == qDocSnap.id);
      }

      Map<dynamic,dynamic> wheelData = {};
      levelData["wheelData"].forEach((key,value) {
        int newKey = int.parse(key);
        wheelData[newKey] = value;
      });

      Map<dynamic,dynamic> clues = {};
      levelData["clues"].forEach((key, value) {
        int newKey = int.parse(key);
        clues[newKey] = value;
      });
      Map<dynamic,dynamic> data = {
        "level": levelData["level"],
        "key": levelData["key"],
        "wheelData": wheelData, 
        "clues":clues,
        "playedData":playedGameDocument,
      };

      // print(playedGameDocument);
      // print("================================================");

      levels.add(data);
  }
  return levels;
  // return docStream.data() as Map<String, dynamic>;
}


// void setScreenSizeData(BuildContext context) {
//   // Set the screen size data directly
//   SettingsState settingsState = context.read<SettingsState>();
  
//   final Size size = MediaQuery.of(context).size;   
  
//   // WidgetsBinding.instance.addPostFrameCallback((_) {
//     final double sizeFactor = size.height < 600 ? 0.7 : 1.0;
//     settingsState.setSizeFactor(sizeFactor);

//   // });
// }



// Widget getSplashScreen() {
//   return Scaffold(
//     backgroundColor: Colors.black,
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Cryptext",
//           style: TextStyle(
//             color: Colors.amber,
//             fontSize: 44,
//           ),
//         ),

//         SizedBox(height: 50,),

//         Align(
//           alignment: Alignment.center,
//           child: Text(
//             "by No Damn Good Studios, Inc.",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),        
//       ],
//     ),
//   );
// }