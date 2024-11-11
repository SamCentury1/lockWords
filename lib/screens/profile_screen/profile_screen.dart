import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/providers/settings_state.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  





  @override
  Widget build(BuildContext context) {


    late ColorPalette palette = Provider.of<ColorPalette>(context,listen:false);
    late SettingsState settingsState = Provider.of<SettingsState>(context,listen: false);
    late Map<dynamic,dynamic> user = settingsState.userData; 

    return Builder(
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: palette.screenBackgroundColor,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: palette.mainTextColor),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen())
                  );              
                }
              ),           
              backgroundColor: Colors.transparent,
              title: Text(
                "Profile",
                style: TextStyle(
                  color: palette.mainTextColor
                ),
              ),
            ),
            body: Column(
              children: [
        
                SizedBox(height: 100),
        
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Container(
                //       width: 150,
                //       height: 150,
                //       child: ClipOval(
                //         clipper: ProfilePictureClipper(),
                //         child: Image.network(user['photoUrl']),
                //       ),
                //     ),
                //   ),
                // ),
                pictureCard(user["photoUrl"]),
        
                SizedBox(height: 20,),
                
        
                usernameCard(palette,settingsState, user['username'], Icons.person_2),
                SizedBox(height: 20,),
                usernameCard(palette,settingsState, user['email'], Icons.email),
        
                SizedBox(height: 20,),
                usernameCard(palette,settingsState, "${user['balance']} coins", Icons.monetization_on),
        
              ],
            ),
          )
        );
      }
    );
  }
}


class ProfilePictureClipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCenter(center: Offset(size.width/2,size.height/2), width: size.width, height: size.height);
  }
  bool shouldReclip(oldClipper) {
    return false;
  }
}

class DefaultUserPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint();
    bgPaint.color = Colors.grey;

    Paint contentPaint = Paint();
    contentPaint.color = Colors.white;

    Offset center = Offset(size.width/2,size.height/2);
    Rect bgRect = Rect.fromCenter(center: center, width: size.width, height: size.height);
    Path bodyPath = Path();
    bodyPath.moveTo(0,size.height);
    bodyPath.quadraticBezierTo(center.dx, center.dy-size.width*0.2, size.width, size.height);
    bodyPath.close();
    canvas.drawRect(bgRect, bgPaint);
    canvas.drawCircle(Offset(center.dx,center.dy-size.width*0.1), size.width*0.2, contentPaint);
    canvas.drawPath(bodyPath, contentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }    
}

Widget pictureCard(String? photoUrl) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Align(
      alignment: Alignment.center,
      child: Container(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: 150,
                height: 150,
                child: ClipOval(
                  clipper: ProfilePictureClipper(),
                  child: photoUrl != null 
                  ? CircleAvatar(
                      child: Image.network(
                        scale: 0.6,
                        photoUrl,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return CircularProgressIndicator();
                        },
                      )
                    )
                  : CustomPaint(
                    painter: DefaultUserPainter(),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  print("open change photo");
                }, 
                icon: Icon(Icons.add_a_photo, color: const Color.fromARGB(255, 8, 8, 8).withOpacity(0.5), size: 32 )
              ),
              // child: Container(
              //   width: 50,
              //   height: 50,
              //   color: Colors.red,
              // )
            )
          ],
        )
      ),
    ),
  );
}


Widget usernameCard(ColorPalette palette, SettingsState settingsState, String body, IconData iconData) {
  late double width = settingsState.screenSizeData["width"]*0.90;
  // late Map<dynamic,dynamic> user = settingsState.userData ;
  return Container(
    width: width,
    height: 70,
    decoration: BoxDecoration(
      color: palette.cryptexAreaColor,
      borderRadius: BorderRadius.all(Radius.circular(12.0))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width * 0.18,
          height: 65,
          // color: Colors.orange,
          child: Center(
            child: Icon(iconData, size: 28, color: palette.mainTextColor,)
          ),
        ),

        Container(
          width: width * 0.78,
          height: 65,
          // color: Colors.brown,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                body,
                style: TextStyle(
                  color: palette.mainTextColor,
                  fontSize: 28
                ),
              ),
            ),
          )
        ),        
      ],
    ),
  );
}
