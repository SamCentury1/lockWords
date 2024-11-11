import 'package:flutter/material.dart';
import 'package:lock_words/providers/color_palette.dart';
import 'package:lock_words/resources/firestore_methods.dart';
import 'package:lock_words/screens/home_screen/home_screen.dart';
import 'package:lock_words/settings/settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController themeColorController = TextEditingController();
  late ColorPalette palette = Provider.of<ColorPalette>(context,listen: false);
  ColorLabel? selectedColor;
  // late SettingsController settings = Provider.of<SettingsController>(context, listen:  false); 
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context,settings,child) {
        late Map<dynamic,dynamic> userData = settings.userData.value as Map<dynamic,dynamic>; 
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
                "Settings",
                style: TextStyle(
                  color: palette.mainTextColor
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                // child: Text(
                //   "Butt secks",
                //   style: TextStyle(
                //     color: palette.mainTextColor,
                //     fontSize: 44,
                //   ),
                // ),
                child: ListView(
                  children: [
                    Card(
                      color: palette.cryptexAreaColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            "Color Theme",
                            style: TextStyle(
                              fontSize: 22
                            ),
                          ),
                          
                          textColor: palette.mainTextColor,
                          trailing: DropdownMenu(
                        
                            controller: themeColorController,
                            textStyle: TextStyle(
                              color: palette.mainTextColor,
        
                            ),
        
                            
                            // requestFocusOnTap is enabled/disabled by platforms when it is null.
                            // On mobile platforms, this is false by default. Setting this to true will
                            // trigger focus request on the text field and virtual keyboard will appear
                            // afterward. On desktop platforms however, this defaults to true.
                            requestFocusOnTap: false,
                            label: Text(
                              'Color',
                              style: TextStyle(
                                color: palette.mainTextColor
                              ),
                            ),
                            onSelected: (ColorLabel? color) async {
                              settings.toggleColorTheme(color!.label);
                              palette.getThemeColors(color.label);
                              FirestoreMethods().updateParameters(userData['uid'],'theme',color.label);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const SettingsScreen())
                              );                            
                            },
                            dropdownMenuEntries: ColorLabel.values.map<DropdownMenuEntry<ColorLabel>>((ColorLabel color) {
                              return DropdownMenuEntry<ColorLabel>(
                                value: color,
                                label: color.label,
                        
                                // enabled: color.label != 'Grey',
                                enabled: true,
                                style: MenuItemButton.styleFrom(
                                  backgroundColor: color.backgroundColor,
                                  foregroundColor: color.textColor,
                                ),
                              );
                            }).toList(),
                          ),                                  
                        ),
                      ),
                    ),
        
                    SizedBox(height: 30,),
        
        
                    Card(
                      color: palette.cryptexAreaColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            settings.soundsOn.value 
                            ? "Sound (On)"
                            : "Sound (Off)",
                            style: TextStyle(
                              fontSize: 22
                            ),
                          ),
                          
                          textColor: palette.mainTextColor,
                          trailing: IconButton(
                            onPressed: () async {
                              settings.toggleSoundsOn();
                              FirestoreMethods().updateParameters(userData['uid'], 'soundOn', !userData['parameters']['soundOn']);
                              setState(() {
                                userData['parameters']['soundOn'] = settings.soundsOn.value;
                              });
                            }, 
                            icon: settings.soundsOn.value
                             ? Icon(Icons.volume_up, color: palette.mainTextColor)
                             : Icon(Icons.volume_off, color: palette.clueCardFlippedColor)
                          )                                 
                        ),
                      ),
                    ),                
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }
}


enum ColorLabel {
  light('light', Color.fromARGB(255, 223, 223, 223),Colors.black ),
  dark('dark', Colors.black, Colors.white,),
  ocean('ocean', Color.fromARGB(255, 191, 219, 241), Color.fromARGB(255, 12, 119, 207)),
  forest('forest', Color.fromARGB(255, 54, 117, 2), Color.fromARGB(255, 200, 245, 202));
  // grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.backgroundColor, this.textColor);
  final String label;
  final Color textColor;
  final Color backgroundColor;
}  