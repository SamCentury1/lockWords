import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/resources/auth_service.dart';
import 'package:lock_words/screens/auth_screen/auth_screen.dart';
import 'package:lock_words/screens/auth_screen/components/auth_error_dialog.dart';
import 'package:lock_words/screens/auth_screen/components/auth_provider_tile.dart';
import 'package:lock_words/screens/auth_screen/components/login_button.dart';
import 'package:lock_words/screens/auth_screen/components/login_textfield.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key,required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signInUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );

    } on FirebaseAuthException catch (e) {
      if (mounted) {
        debugPrint(e.toString());
        AuthService().authenticationFailed(context, e.code);
      }
    }
    
    // Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    late ColorPalette palette = Provider.of<ColorPalette>(context, listen:false);
    late SettingsState settingsState = Provider.of<SettingsState>(context, listen:false);
    final double sizeFactor = settingsState.sizeFactor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: palette.screenBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0 * sizeFactor),
          child: Column(
            children: [
              // SizedBox(height: 50,),
              // Icon(Icons.lock,size: 100,),
              Expanded(
                flex: 2, 
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
                      "Welcome back!",
                      // style: TextStyle(color: Colors.grey[700],fontSize: 24),
                      style: TextStyle(color: palette.mainTextColor,fontSize: 24*sizeFactor),
                    ),
                    // SizedBox(height: 15,),
                    LoginTextField(controller: emailController, hintText: 'Email', obscureText: false, palette: palette,),
                    // SizedBox(height: 25,),
                    LoginTextField(controller: passwordController, hintText: 'Password', obscureText: true, palette: palette,),
                    // SizedBox(height: 10,),
                
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "forgot password?",
                        style: TextStyle(color: palette.clueCardTextColor,fontSize: 16 * sizeFactor),
                      ),
                    ),
                
                    // SizedBox(height: 20),
                    LoginButton(onTap: signInUser, body: "Sign In", palette: palette,),
                    // SizedBox(height: 20),
                
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0 * sizeFactor),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 0.5 * sizeFactor, color: palette.mainTextColor,),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0 * sizeFactor),
                            child: Text(
                              "or continue with",
                              style: TextStyle(
                                color: palette.mainTextColor,
                                fontSize: 16 * sizeFactor
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 0.5 * sizeFactor, color: palette.mainTextColor,),
                          )                      
                        ],
                      )
                    ),

                    // SizedBox(height: 20,),
                
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
                    // SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("not a member?", 
                          style: TextStyle(
                            color: palette.clueCardTextColor,
                            fontSize: 16.0 * sizeFactor
                          )
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            "register now",
                            style: TextStyle(
                              color: palette.clueCardFlippedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16 * sizeFactor
                            ),
                          ),
                        )
                
                      ],
                    ),                    
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}