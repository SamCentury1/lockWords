import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lock_words/screens/auth_screen/components/auth_error_dialog.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // User? get currentUser => _firebaseAuth.currentUser;
  Future<void> createAnonymousUser() async {
    UserCredential cred = await _firebaseAuth.signInAnonymously();
    await _firestore.collection("users").doc(cred.user!.uid).set({
      "uid": cred.user!.uid,
      "username": "",
      "emails": "",
      "createdAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> registerUserManually(String email, String password, String username) async {
    UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    late String os = "";
    if (Platform.isAndroid) {
      os = 'android';
    } else {
      os = 'iOS';
    }    
    if (cred.additionalUserInfo!.isNewUser) {
      await _firestore.collection("users").doc(cred.user!.uid).set({
        "uid": cred.user!.uid,
        "username": username,
        "email": email,
        "photoUrl": null,
        "parameters" : {
          "muted": false,
          "soundOn": true,
          "theme": 'dark',
        },
        "createdAt": DateTime.now().toIso8601String(),
        "providerData": "none",
        "os": os,
        "balance": 5
      });        
    }    
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]
      );
      final oAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential cred =  await _firebaseAuth.signInWithCredential(oAuthCredential);
      late String os = "iOS";

      if (cred.additionalUserInfo!.isNewUser) {
        await _firestore.collection("users").doc(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "username": cred.user!.displayName,
          "email": cred.user!.email,
          "photoUrl": cred.user!.photoURL,
          "parameters" : {
            "muted": false,
            "soundOn": true,
            "theme": 'dark',
          },
          "createdAt": DateTime.now().toIso8601String(),
          "providerData": "google",
          "os": os,
          "balance": 5
        });        
      }

      return cred;

    }catch (e) {
      print("Error with Sign in with Apple => $e ");
      return null;
    }
  }
 

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    UserCredential cred = await FirebaseAuth.instance.signInWithCredential(credential);

    late String os = "";
    if (Platform.isAndroid) {
      os = 'android';
    } else {
      os = 'iOS';
    }

    if (cred.additionalUserInfo!.isNewUser) {
      await _firestore.collection("users").doc(cred.user!.uid).set({
        "uid": cred.user!.uid,
        "username": cred.user!.displayName,
        "email": cred.user!.email,
        "photoUrl": cred.user!.photoURL,
        "parameters" : {
          "muted": false,
          "soundOn": true,
          "theme": 'dark',
        },
        "createdAt": DateTime.now().toIso8601String(),
        "providerData": "google",
        "os": os,
        "balance": 5
      });        
    }

    return cred;
  }


  void addUserToDatabase(UserCredential cred) {

  }



  Future<void> signOut() async {
    print("logging out");
    await _firebaseAuth.signOut();
  }  

  // Future<void> signInUser(BuildContext context, String email, String password) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email, 
  //       password: password
  //     );
  //     // Navigator.pop(context);


  //   } on FirebaseAuthException catch (e) {
  //     AuthenticationHelpers().loginFailed(context,e.code);
  //     // Navigator.pop(context);
  //     // if (e.code == 'invalid-credential') {
  //     //   AuthenticationHelpers().loginFailed(context,e.code);
  //     // } else if (e.code == 'invalid-email') {
  //     //   loginFailed(context,e.code);
  //     // } else if (e.code == 'channel-error') {
  //     //   loginFailed(context,e.code);
  //     // }
  //   }  
  // }


  // Future<void> loginUser() async {

  // }


  Future<void> authenticationFailed(BuildContext context, String error) async {
    if (error == 'invalid-credential') {
      return showLoginFailedDialog(
        context,
        "Invalid Credentials",
        ["Please provide a valid email and password combination."]
      );
    } else if (error == 'invalid-email') {
      return showLoginFailedDialog(
        context,
        "Invalid Email",
        ["Please provide a valid email address."]
      );
    } else if (error == 'channel-error') {
      return showLoginFailedDialog(
        context,
        "Unexpected Error",
        ["Please populate all fields before continuing."]
      );
    } else if (error == 'user-disabled') {
      return showLoginFailedDialog(
        context, 
        "User Disabled", 
        ["This user has been disabled, please create a new account."]
      );
    } else if (error == 'wrong-password') {
      return showLoginFailedDialog(
        context, 
        "Wrong Password", 
        ["Please enter the correct password or tap 'forgot password'."]
      );
    } else if (error == 'too-many-requests') {
      return showLoginFailedDialog(
        context, 
        "Too Many Requests", 
        ["Too many requests have been sent simultaneously, for security - please come back later."]
      );
    } else if (error == 'user-token-expired') {
      return showLoginFailedDialog(
        context, 
        "User Token Expired", 
        ["You are no longer authenticated since your refresh token has been expired."]
      );
    } else if (error == 'network-request-failed') {
      return showLoginFailedDialog(
        context, 
        "Network Request Error", 
        ["Please make sure you are connected to the internet to authenticate."]
      );
    } else if (error == 'operation-not-allowed') {
      return showLoginFailedDialog(
        context, 
        "Operation Not Allowed", 
        ["Please reach out to support for assistance."]
      );
    } else if (error == 'operation-not-allowed') {
      return showLoginFailedDialog(
        context, 
        "Operation Not Allowed", 
        ["Please reach out to support for assistance."]
      );

      /// =======================================
    } else if (error == 'email-already-in-use') {
      return showLoginFailedDialog(
        context, 
        "Email already in use", 
        ["This email is already in use. Please choose another email or tap 'forgot password'."]
      );
    } else {
      return showLoginFailedDialog(
        context, 
        "Unexpected Error", 
        ["Please reach out to support for assistance."]
      );
    }
  }

  Future<void> showLoginFailedDialog(BuildContext context, String title , List<String> errors,) async {

    return await showDialog(
      context: context, 
      builder: (context) {
        return AuthErrorDialog(
          errorTitle: title, 
          errors: errors
        );
      }
    );
  }  

}