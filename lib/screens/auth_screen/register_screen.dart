import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/auth_service.dart';
import 'package:lock_words/screens/auth_screen/components/auth_error_dialog.dart';
import 'package:lock_words/screens/auth_screen/components/auth_provider_tile.dart';
import 'package:lock_words/screens/auth_screen/components/login_button.dart';
import 'package:lock_words/screens/auth_screen/components/login_textfield.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void registerUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      List<String> errors = [];
      if (password1Controller.text != password2Controller.text) {
        errors.add("passwords don't match");
      }

      if (password1Controller.text.length <= 6) {
        errors.add("passowrd must be over 6 characters");        
      }

      if (errors.isEmpty) {

        await AuthService().registerUserManually(emailController.text, password1Controller.text,usernameController.text);
   
      } else {
        AuthService().showLoginFailedDialog(context, "Errors", errors);
      }

    } on FirebaseAuthException catch (e) {
      if (mounted) {
        debugPrint(e.toString());
        AuthService().authenticationFailed(context, e.code);
      }
    }
  }


  // void authError(String error) {
  //   showDialog(
  //     context: context, 
  //     builder: (context) {
  //       return AuthErrorDialog(
  //         errorTitle: errorTitle, 
  //         errorText: errorText
  //       );
  //     }
  //   );
  // }

  // void registrationError(List<String> body) {
  //   showDialog(
  //     context: context, 
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Error"),
  //         content: Column(
  //           children: [
  //             for (String item in body)
  //             Text(item)
  //           ]
  //         ),
  //       );
  //     }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen:false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    final double sizeFactor = settingsState.sizeFactor;  

    return Scaffold(
      backgroundColor: palette.screenBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0 * sizeFactor),
          child: Column(
            children: [
              Expanded(
                flex: 1, 
                child: SizedBox(
                  child: Center(
                    child: Image.asset('assets/images/temp_logo.png'),
                  ),
                )
              ),

              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(color: palette.clueCardTextColor,fontSize: 24 * sizeFactor),
                    ),

                    LoginTextField(controller: usernameController, hintText: 'Username', obscureText: false, palette: palette,),
                
                    LoginTextField(controller: emailController, hintText: 'Email', obscureText: false, palette: palette,),

                    LoginTextField(controller: password1Controller, hintText: 'Password', obscureText: true, palette: palette,),
                
                    LoginTextField(controller: password2Controller, hintText: 'Confirm Password', obscureText: true, palette: palette,),

                    LoginButton(onTap: registerUser, body: "Register", palette: palette,),
                
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0 * sizeFactor),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 0.5*sizeFactor, color: palette.clueCardTextColor),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0 * sizeFactor),
                            child: Text(
                              "or continue with",
                              style: TextStyle(
                                color: palette.clueCardTextColor,
                                fontSize: 16*sizeFactor
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 0.5*sizeFactor, color: palette.clueCardTextColor),
                          )                      
                        ],
                      )
                    ),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthProviderTile(
                          palette: palette, 
                          onTap: () => AuthService().signInWithGoogle(), 
                          iconData: Icons.g_mobiledata,
                        ),
                        SizedBox(width: 10,),

                        AuthProviderTile(
                          palette: palette, 
                          onTap: () => print('caca butt'),
                          iconData: Icons.apple,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already a member?", 
                          style: TextStyle(
                            color: palette.clueCardTextColor,
                            fontSize: 16.0 *sizeFactor,
                          )
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            "login now",
                            style: TextStyle(
                              color: palette.clueCardFlippedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0 *sizeFactor,
                            ),
                          ),
                        )
                
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}