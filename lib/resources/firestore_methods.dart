import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lock_words/providers/game_play_state.dart';
import 'package:lock_words/providers/settings_state.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // EXECUTES IN THE SETTINGS PAGE - IN THE DROPOWN MENU FOR CHANGING THE CURRENT LANGUAGE
  Future<void> updateParameters(String uid, String parameter, dynamic updatedValue) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final docSnap = await docRef.get();
      final Map<String, dynamic> docData = docSnap.data() as Map<String, dynamic>;

      Map<String, dynamic> parameters = docData['parameters'];

      parameters.update(parameter, (value) => updatedValue);

      await docRef.update({"parameters": parameters});
    } catch (e) {
      // debugPrint("caught an error running 'updateParameters()' ${e.toString()}");
    }
  }

  Future<void> updateBalance(String uid, int newBalance) async {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      await docRef.update({"balance": newBalance});    
  }




  // Future<void> getGamesPlayed(String uid) async {
  //   // final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
  //   final levelsDoc = await _firestore.collection('games').where("playerId", isEqualTo: uid).get();
  //   for (DocumentSnapshot levelSnap in levelsDoc.docs) {
  //     print(levelSnap.id);
  //   }
  // }


  Future<void> saveGame(SettingsState settingsState, GamePlayState gamePlayState) async {
    try {

      /// Get the level ID
      Map<String,dynamic> gameData = gamePlayState.gameData;
      final levelDoc = await _firestore.collection('levels').where("level", isEqualTo: gameData["level"]).get();
      DocumentSnapshot levelSnapshot = levelDoc.docs.first;
      String levelId = levelSnapshot.id;

      /// Get the player ID
      String playerId = FirebaseAuth.instance.currentUser!.uid;

      /// Check to see if this game has an existing document
      final gameDocuments = await _firestore.collection('games')
      .where("levelId", isEqualTo: levelId)
      .where("userId", isEqualTo: playerId)
      .get();
      List<QueryDocumentSnapshot> gameDocSnapshots = gameDocuments.docs;

      /// get the data we want to save
      Map<String,dynamic> gameDataToSave = {
        "userId": playerId,
        "levelId": levelId,
        "createdAt": gameData["createdAt"],
        "time": gameData["time"],
        "score": gameData["score"],
        "cluesLeft" : gameData["cluesLeft"],
        "completed": gameData["cluesLeft"].isEmpty ? true : false,
      };

      // update the balance in either scenario
      int newBalance = gameData["endingBalance"];
      updateBalance(playerId, newBalance);      

      /// if empty => create a new game
      if (gameDocSnapshots.isEmpty) {
        await _firestore.collection('games').add(gameDataToSave);        
      }
      
      /// if not empty => update document 
      else {
        String gameId = gameDocSnapshots.first.id;
         await _firestore.collection('games').doc(gameId).set(gameDataToSave);
      }

      gamePlayState.quitGame();      
      
    } catch (e) {
      print(e.toString());
    }
  }


  // Future<void> saveIncompleteGame(SettingsState settingsState, GamePlayState gamePlayState) async {
  //   try {
  //     /// get the game data
  //     Map<String,dynamic> gameData = gamePlayState.gameData;

  //     /// Get the level ID
  //     final levelDoc = await _firestore.collection('levels').where("level", isEqualTo: gameData["level"]).get();
  //     DocumentSnapshot levelSnapshot = levelDoc.docs.first;
  //     String levelId = levelSnapshot.id;

  //     // get the player id
  //     String playerId = FirebaseAuth.instance.currentUser!.uid;

  //     // update the user's balance
  //     int newBalance = gameData["endingBalance"];
  //     updateBalance(playerId, newBalance);

  //     // 
  //     await _firestore.collection('games').add({
  //       "userId": playerId,
  //       "levelId": levelId,
  //       "createdAt": gameData["createdAt"],
  //       "time": gameData["time"],
  //       "score": gameData["score"],
  //       "completed": true,
  //     });

  //     gamePlayState.quitGame();
      
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }  




  // Future<void> createLevels(SettingsState settingsState) async {
  //   try {

  //     // for (int i=0; i<settingsState.levelData.length; i++) {
  //     for (int i=0; i<settingsState.levelData.length; i++) {
  //       // Map<String,dynamic> data = settingsState.levelData[i] as Map<String,dynamic>; // as Map<String,dynamic>;
  //       Map<String,dynamic> data = {
  //         "level": settingsState.levelData[i]["level"],
  //         "wheelData": settingsState.levelData[i]["wheelData"],
  //         "clues": settingsState.levelData[i]["clues"],
  //       };
  //       await _firestore.collection("levels").doc().set(data);
  //       print("added level $i");
  //     }

      
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}

