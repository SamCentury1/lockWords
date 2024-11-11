import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  late Map<String, dynamic> _screenSizeData = {
    "width": 0.0, 
    "height": 0.0,
    // "cluesWidgetHeight":0.0,
    "cryptexHeight": 0.0,
  };
  Map<String, dynamic> get screenSizeData => _screenSizeData;
  void setScreenSizeData(Map<String, dynamic> value) {
    _screenSizeData = value;
    notifyListeners();
  }


  late Map<dynamic, dynamic> _userData = {};
  Map<dynamic, dynamic> get userData => _userData;
  void setUserData(Map<dynamic, dynamic> value) {
    _userData = value;
    notifyListeners();
  }

  late List<Map<dynamic,dynamic>> _levelData = [];
  List<Map<dynamic,dynamic>> get levelData => _levelData;
  void setLevelData(List<Map<dynamic,dynamic>>  value) {
    _levelData = value;
    notifyListeners();
  }
  
//   final List<Map<String,dynamic>> _levelData = [
//     {
//       'level': 1,
//       'wheelData': {
//         "0": ['T', 'M', 'W', 'C', 'P'],
//         "1": ['N', 'R', 'U', 'T', 'E'],
//         "2": ['O', 'P', 'A', 'B', 'I'],
//         "3": ['A', 'T', 'N', 'F', 'V'],
//         "4": ['K', 'N', 'E', 'H', 'S']
//       },
//       'clues': {
    
//         "0": {'key': 0, 'value': 3, 'hintOpen': false,'word': 'CRANE', 'active': true, 'clue': 'Big structure used to build skyscrapers'},
//         "1": {'key': 1, 'value': 3, 'hintOpen': false,'word': 'CRANK', 'active': true, 'clue': 'also known as crystal meth'},
//         "2": {'key': 2, 'value': 3, 'hintOpen': false,'word': 'CRATE', 'active': true, 'clue': 'a case to transport goods'},
//         "3": {'key': 3, 'value': 2, 'hintOpen': false,'word': 'CRAVE', 'active': false, 'clue': 'a strong desire'},
//         "4": {'key': 4, 'value': 3, 'hintOpen': false,'word': 'CROAK', 'active': false, 'clue': 'a sound a frog makes'},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'word': 'CRONE', 'active': false, 'clue': 'in folklore, an ugly old woman'},
//         "6": {'key': 6, 'value': 4, 'hintOpen': false,'word': 'MEANS', 'active': false, 'clue': 'ways & ...'},
//         "7": {'key': 7, 'value': 2, 'hintOpen': false,'word': 'MEATS', 'active': false, 'clue': 'a butcher is nothing without these'},
//         "8": {'key': 8, 'value': 2, 'hintOpen': false,'word': 'PRANK', 'active': false, 'clue': 'deceiving someone humourously'},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'word': 'PRATE', 'active': false, 'clue': 'to talk at great length but with little meaning'},
//         "10": {'key': 10, 'value': 4, 'hintOpen': false,'word': 'PRINK', 'active': false, 'clue': " to spend time making minor adjustments to one's appearance"},
//         "11": {'key': 11, 'value': 3, 'hintOpen': false,'word': 'PRONE', 'active': false, 'clue': 'likely to or liable to suffer from, do, or experience something'},
//         "12": {'key': 12, 'value': 3, 'hintOpen': false,'word': 'PROVE', 'active': false, 'clue': 'demonstrate the truth or existence'},
//         "13": {'key': 13, 'value': 4, 'hintOpen': false,'word': 'TRANS', 'active': false, 'clue': 'prefix to show a cross between two things'},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'word': 'TRITE', 'active': false, 'clue': 'lacking in freshness or effectiveness because of constant use'},
//         "15": {'key': 15, 'value': 3, 'hintOpen': false,'word': 'TROVE', 'active': false, 'clue': 'a store of valuable or delightful things'},
//         "16": {'key': 16, 'value': 3, 'hintOpen': false,'word': 'WEAVE', 'active': false, 'clue': 'artifitial hairstyle'},
//         "17": {'key': 17, 'value': 3, 'hintOpen': false,'word': 'WRATH', 'active': false, 'clue': 'extreme anger'},
//         "18": {'key': 18, 'value': 3, 'hintOpen': false,'word': 'WRITE', 'active': false, 'clue': 'I will transcribe onto paper'},
//         "19": {'key': 19, 'value': 3, 'hintOpen': false,'word': 'WROTE', 'active': false, 'clue': 'I transcribed onto paper'},

         
//       }
//     },
//     {
//       'level': 2,
//       'wheelData': {
//         "0": ['R', 'A', 'F', 'L', 'S'],
//         "1": ['A', 'N', 'R', 'E', 'U'],
//         "2": ['D', 'O', 'T', 'E', 'I'],
//         "3": ['E', 'P', 'F', 'O', 'R'],
//         "4": ['S', 'M', 'N', 'Y', 'R']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'word': 'ANION', 'active': true, 'clue': 'a negatively charged ion, i.e. one that would be attracted to the anode in electrolysis.'},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'word': 'ANTES', 'active': true, 'clue': 'stakes put up by a player in poker and similar games before receiving cards.'},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'word': 'ARDOR', 'active': true, 'clue': 'enthusiasm or passion.'},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'word': 'AUTOS', 'active': true, 'clue': 'cars'},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'word': 'FADES', 'active': true, 'clue': 'gradually disappearing'},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'word': 'FAIRS', 'active': true, 'clue': 'where one can get lots of deep fried things'},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'word': 'FAIRY', 'active': true, 'clue': "makes kids' wishes come true"},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'word': 'FATES', 'active': true, 'clue': 'the daughters of either Nyx (the Night) or of Zeus and Themis (Law and Justice).'},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'word': 'FREER', 'active': true, 'clue': 'more free'},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'word': 'FREES', 'active': true, 'clue': 'to release from captivity'},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'word': 'FRIER', 'active': true, 'clue': 'you can expect to find alot of these at the fair'},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'word': 'FRIES', 'active': true, 'clue': 'called chips in the UK'},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'word': 'LADEN', 'active': true, 'clue': 'heavily loaded '},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'word': 'LATER', 'active': true, 'clue': 'not now, maybe then'},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'word': 'LEERY', 'active': true, 'clue': 'not trusting someone or something'},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'word': 'RATES', 'active': true, 'clue': 'these get cut when inflation is too high'},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'word': 'REEFS', 'active': true, 'clue': 'where corals live'},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'word': 'RETRY', 'active': true, 'clue': 'to give it another go'},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'word': 'RUDER', 'active': true, 'clue': 'more rude than that'},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'word': 'SNEER', 'active': true, 'clue': 'contemptuous mocking'}
//       }
//     },
//     {
//       'level': 3,
//       'wheelData': {
//         "0": ['L', 'G', 'A', 'S', 'O'],
//         "1": ['E', 'O', 'I', 'H', 'W'],
//         "2": ['A', 'P', 'B', 'E', 'O'],
//         "3": ['L', 'E', 'D', 'G', 'P'],
//         "4": ['Y', 'N', 'T', 'S', 'M']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'word': 'GOALS', 'active': true, 'clue': 'strikers score'},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'word': 'GOODS', 'active': true, 'clue': 'exchanged at the market'},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'word': 'GOODY', 'active': true, 'clue': 'informally, something attractive or desirable'},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'word': 'GOOEY', 'active': true, 'clue': 'the superior chocolate chip cookie is of this variety'},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'word': 'LEADS', 'active': true, 'clue': 'sales people rely on these'},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'word': 'LEAPS', 'active': true, 'clue': 'frogs and crickets make these'},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'word': 'LOADS', 'active': true, 'clue': 'heavy cargo'},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'word': 'LOBES', 'active': true, 'clue': 'on your ears'},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'word': 'LOOPS', 'active': true, 'clue': 'also can be on your ears'},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'word': 'LOOPY', 'active': true, 'clue': 'having many loops'},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'word': 'LOPPY', 'active': true, 'clue': 'hanging limply'},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'word': 'SEALS', 'active': true, 'clue': 'big water puppies'},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'word': 'SEEDS', 'active': true, 'clue': 'plant them in the ground'},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'word': 'SEEDY', 'active': true, 'clue': 'sordid and disreputable'},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'word': 'SHADY', 'active': true, 'clue': 'situated in or full of shade'},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'word': 'SHEDS', 'active': true, 'clue': 'little cabin for storage'},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'word': 'SHEEN', 'active': true, 'clue': 'this man has tiger blood'},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'word': 'SHEET', 'active': true, 'clue': 'a thin surface to write on'},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'word': 'SHOES', 'active': true, 'clue': 'foot protectors'},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'word': 'SHOPS', 'active': true, 'clue': 'where goods are mainly sold'},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false,'word': 'SIPES', 'active': true, 'clue': 'a groove or channel in the tread of a tire to improve its grip'},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false,'word': 'SOAPS', 'active': true, 'clue': 'to bathe without these is merely to swim'},
//         "22": {'key': 22, 'value': 5, 'hintOpen': false,'word': 'SOAPY', 'active': true, 'clue': 'foamy'},
//         "23": {'key': 23, 'value': 5, 'hintOpen': false,'word': 'SOPPY', 'active': true, 'clue': 'self-indulgently sentimental'},
//         "24": {'key': 24, 'value': 5, 'hintOpen': false,'word': 'SWAPS', 'active': true, 'clue': 'exchanging '},
//         "25": {'key': 25, 'value': 5, 'hintOpen': false,'word': 'SWEET', 'active': true, 'clue': 'candies tend to be'},
//         "26": {'key': 26, 'value': 5, 'hintOpen': false,'word': 'SWEPT', 'active': true, 'clue': 'to be defeated 4 consecutive games in the NBA or NHL playoffs'}
//       }  
//     },
//     {
//       'level': 4,
//       'wheelData': {
//         "0": ['P', 'C', 'B', 'R', 'A'],
//         "1": ['I', 'H', 'U', 'L', 'P'],
//         "2": ['I', 'U', 'G', 'T', 'L'],
//         "3": ['A', 'T', 'M', 'N', 'V'],
//         "4": ['S', 'Y', 'P', 'E', 'A']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'word': 'ALGAE', 'active': true, 'clue': 'Found at the beach'},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'word': 'ALIAS', 'active': true, 'clue': 'also known as'},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'word': 'ALIVE', 'active': true, 'clue': 'beegees sang about staying this way'},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'word': 'ALLAY', 'active': true, 'clue': 'to subdue or reduce in intensity'},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'word': 'BITTS', 'active': true, 'clue': 'pair of posts fixed on the deck of a ship for securing lines'},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'word': 'BITTY', 'active': true, 'clue': 'not cohesive or flowing'},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'word': 'BLIMP', 'active': true, 'clue': 'on the cover of Led Zeppeling I'},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'word': 'BUTTE', 'active': true, 'clue': 'A kind of hill or rock formation'},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'word': 'BUTTS', 'active': true, 'clue': 'kicking these means you are doing great'},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'word': 'CHIME', 'active': true, 'clue': 'I want to get me two cents in, I will ____ in'},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'word': 'CHINA', 'active': true, 'clue': 'where Winnie the Pooh and democracy are banned'},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'word': 'CHINE', 'active': true, 'clue': 'a cut of meat including all or part of the backbone'},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'word': 'CHIVE', 'active': true, 'clue': 'this herb adds color to any dish'},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'word': 'CHIVY', 'active': true, 'clue': 'to tease or annoy with persistent petty attacks'},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'word': 'CHUMP', 'active': true, 'clue': 'informally - a person easy to deceive'},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'word': 'CHUTE', 'active': true, 'clue': 'a fall'},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'word': 'CLUMP', 'active': true, 'clue': 'a group of things clustered together'},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'word': 'CULTS', 'active': true, 'clue': "Scientology is one of these"},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'word': 'PLUME', 'active': true, 'clue': 'a feather'},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'word': 'PLUMP', 'active': true, 'clue': 'looking juicy'},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false,'word': 'PUTTY', 'active': true, 'clue': 'a kind of pasty paste'},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false,'word': 'RUINS', 'active': true, 'clue': 'to ruin something will leave it in ____'}
//       }
//     },
//     {
//       'level': 5,
//       'wheelData': {
//         "0": ['S', 'P', 'F', 'T', 'A'],
//         "1": ['I', 'U', 'E', 'R', 'O'],
//         "2": ['D', 'A', 'R', 'N', 'P'],
//         "3": ['E', 'O', 'T', 'U', 'R'],
//         "4": ['A', 'Y', 'R', 'S', 'P']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'active': true,"word":"AIDES", "clue": "Assistants at work.",},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'active': true,"word":"AIRER", "clue": "A person who broadcasts.",},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'active': true,"word":"AORTA", "clue": "Main artery of the body.",},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'active': true,"word":"ARDOR", "clue": "Intense passion or enthusiasm.",},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'active': true,"word":"AUNTS", "clue": "Relatives on your parent’s side.",},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'active': true,"word":"AUNTY", "clue": "Endearing term for mom's sister.",},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'active': true,"word":"FEARS", "clue": "Things that cause anxiety.",},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'active': true,"word":"FEATS", "clue": "Remarkable achievements.",},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'active': true,"word":"FERRY", "clue": "Boat that transports vehicles.",},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'active': true,"word":"FINER", "clue": "Of better quality.",},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'active': true,"word":"FINES", "clue": "Monetary penalties.",},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'active': true,"word":"FIRES", "clue": "Sources of heat, or dismisses.",},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'active': true,"word":"FONTS", "clue": "Typographic styles.",},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'active': true,"word":"FORTS", "clue": "Military strongholds.",},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'active': true,"word":"FORTY", "clue": "Number after thirty-nine.",},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'active': true,"word":"FUROR", "clue": "Public uproar or frenzy.",},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'active': true,"word":"FURRY", "clue": "Covered with soft hair.",},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'active': true,"word":"PEARS", "clue": "Juicy, bell-shaped fruits.",},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'active': true,"word":"PERRY", "clue": "Fermented pear drink.",},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'active': true,"word":"PINES", "clue": "Evergreen trees.",},

//       }
//     },
//     {
//       'level': 6,
//       'wheelData': {
//         "0": ['S', 'P', 'F', 'T', 'A'],
//         "1": ['I', 'U', 'E', 'R', 'O'],
//         "2": ['D', 'A', 'R', 'N', 'P'],
//         "3": ['E', 'O', 'T', 'U', 'R'],
//         "4": ['A', 'Y', 'R', 'S', 'P']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'active': true,"word":"PINEY", "clue": "Resembling or full of pines.",},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'active': true,"word":"PINTS", "clue": "Units of liquid measure.",},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'active': true,"word":"PIPER", "clue": "One who plays the pipes.",},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'active': true,"word":"PIPES", "clue": "Hollow tubes for liquid or gas.",},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'active': true,"word":"POPES", "clue": "Leaders of the Catholic Church.",},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'active': true,"word":"PORES", "clue": "Tiny skin openings.",},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'active': true,"word":"PORTA", "clue": "A gateway or entrance.",},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'active': true,"word":"PORTS", "clue": "Harbor cities for ships.",},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'active': true,"word":"PUNTY", "clue": "Tool for shaping glass.",},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'active': true,"word":"PURER", "clue": "More refined or clean.",},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'active': true,"word":"SEARS", "clue": "Burns with intense heat.",},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'active': true,"word":"SEATS", "clue": "Places to sit.",},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'active': true,"word":"SIDES", "clue": "Edges or teams in a debate.",},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'active': true,"word":"SINES", "clue": "Trigonometric functions.",},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'active': true,"word":"SINUS", "clue": "Air-filled cavity in the skull.",},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'active': true,"word":"SIPES", "clue": "Grooves in a tire for traction.",},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'active': true,"word":"SIRES", "clue": "Male parents in livestock.",},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'active': true,"word":"SIRUP", "clue": "Another word for syrup.",},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'active': true,"word":"SOPOR", "clue": "A state of deep sleep.",},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'active': true,"word":"SORES", "clue": "Painful skin abrasions.",},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false,'active': true,"word":"SORRY", "clue": "Apologetic or remorseful.",},
        
//       }
//     },
//     {
//       'level': 7,
//       'wheelData': {
//         "0": ['S', 'P', 'F', 'T', 'A'],
//         "1": ['I', 'U', 'E', 'R', 'O'],
//         "2": ['D', 'A', 'R', 'N', 'P'],
//         "3": ['E', 'O', 'T', 'U', 'R'],
//         "4": ['A', 'Y', 'R', 'S', 'P']
//       },
//       'clues': {
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'active': true,"word":"SORTA", "clue": "Informal for 'kind of.'",},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'active': true,"word":"SORTS", "clue": "Arranges into categories.",},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'active': true,"word":"SORUS", "clue": "Spore-producing structure.",},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'active': true,"word":"SUDRA", "clue": "Lowest caste in India.",},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'active': true,"word":"SUNUP", "clue": "Dawn or daybreak.",},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'active': true,"word":"SUPER", "clue": "Excellent or very good.",},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'active': true,"word":"SUPRA", "clue": "Above or over.",},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'active': true,"word":"SURER", "clue": "More certain or confident.",},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'active': true,"word":"TEARS", "clue": "Drops from crying.",},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'active': true,"word":"TEARY", "clue": "Close to tears.",},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'active': true,"word":"TENOR", "clue": "A male singing voice.",},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'active': true,"word":"TENTS", "clue": "Portable shelters for camping.",},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'active': true,"word":"TERRA", "clue": "Latin for 'earth.'",},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'active': true,"word":"TERRY", "clue": "Absorbent fabric or name.",},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'active': true,"word":"TIARA", "clue": "Decorative crown for women.",},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'active': true,"word":"TIDES", "clue": "Ocean movements caused by the moon.",},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'active': true,"word":"TIRES", "clue": "Worn out, or parts of a vehicle.",},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'active': true,"word":"TONER", "clue": "Skin cleanser or ink cartridge.",},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'active': true,"word":"TONES", "clue": "Shades or sound pitches.",},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false,'active': true,"word":"TORUS", "clue": "Geometric shape like a doughnut.",},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false,'active': true,"word":"TUNES", "clue": "Musical melodies.",}
//       }
//     },        
//     {
//       'level': 8,
//       'wheelData': {
//         "0": ['Q', 'P', 'S', 'C', 'R'],
//         "1": ['O', 'A', 'E', 'R', 'H'],
//         "2": ['S', 'M', 'U', 'O', 'E'],
//         "3": ['W', 'B', 'U', 'F', 'R'],
//         "4": ['N', 'T', 'S', 'D', 'A']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false, 'active': true, "word":"CHEFS","clue":"Kitchen kings with knives and recipes",},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false, 'active': true, "word":"CHERT","clue":"Hard rock often used for tools, it's no flint",},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false, 'active': true, "word":"CHORD","clue":"It strikes a harmonious note in music",},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false, 'active': true, "word":"CHUFA","clue":"Nutty snack often enjoyed by elephants",},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false, 'active': true, "word":"CHURN","clue":"Butter maker's tool that spins and spins",},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false, 'active': true, "word":"COMBS","clue":"Hair tamers or honey hive inspectors",},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false, 'active': true, "word":"COURT","clue":"Legal setting or a place to play tennis",},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false, 'active': true, "word":"CREWS","clue":"Teams that work on ships or movie sets",},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false, 'active': true, "word":"CROFT","clue":"Small farm, often in Scotland's green hills",},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false, 'active': true, "word":"CROWD","clue":"It's packed with people, especially at concerts",},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false, 'active': true, "word":"CROWN","clue":"Royal headgear fit for a king or queen",},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false, 'active': true, "word":"CROWS","clue":"Birds that caw or braggers that boast",},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false, 'active': true, "word":"CRURA","clue":"Leg bones supporting your movement",},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false, 'active': true, "word":"PEERS","clue":"Equals in rank or fellow aristocrats",},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false, 'active': true, "word":"POURS","clue":"What you do to fill a glass with water",},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false, 'active': true, "word":"PROUD","clue":"Feeling accomplished or bursting with pride",},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false, 'active': true, "word":"RAMUS","clue":"Branch of a bone or a botanical split",},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false, 'active': true, "word":"REEFS","clue":"Underwater structures home to colorful fish",},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false, 'active': true, "word":"ROOFS","clue":"Overhead covers keeping houses dry",},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false, 'active': true, "word":"SAMBA","clue":"Brazilian dance with a quick, lively rhythm",},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHERD","clue":"Broken pottery piece found in an archaeological dig",},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHEWS","clue":"Old-fashioned way to say 'displays'",},
//         "22": {'key': 22, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHORN","clue":"What sheep are after a haircut",},
//         "23": {'key': 23, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHORT","clue":"Opposite of tall or long in length",},
//         "24": {'key': 24, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHOUT","clue":"Raise your voice loudly to be heard",},
//         "25": {'key': 25, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHOWN","clue":"Displayed or demonstrated to others",},
//         "26": {'key': 26, 'value': 5, 'hintOpen': false, 'active': true, "word":"SHOWS","clue":"Performances you attend at the theater",},
//         "27": {'key': 27, 'value': 5, 'hintOpen': false, 'active': true, "word":"SOURS","clue":"What lemons and vinegar tend to do to taste",}
//       }
//     },
//     {
//       'level': 9,
//       'wheelData': {
//         "0": ['H', 'R', 'D', 'E', 'O'],
//         "1": ['A', 'H', 'N', 'D', 'R'],
//         "2": ['N', 'Z', 'T', 'L', 'R'],
//         "3": ['N', 'D', 'O', 'E', 'L'],
//         "4": ['S', 'D', 'T', 'A', 'R']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false, 'active': true, "word": "DARED", "clue": "Took a bold risk, or accepted a challenge",},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false, 'active': true, "word": "DARES", "clue": "Challenges people to do something wild",},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false, 'active': true, "word": "DATED", "clue": "Went out for a romantic evening",},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false, 'active': true, "word": "DATER", "clue": "One who goes on romantic outings",},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false, 'active': true, "word": "DATES", "clue": "Sweet fruits or romantic meetups",},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false, 'active': true, "word": "DAZED", "clue": "Confused and out of it, like after a surprise",},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false, 'active': true, "word": "EARNS", "clue": "Gets something through hard work or effort",},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false, 'active': true, "word": "EATER", "clue": "One who consumes food, hungry or not",},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false, 'active': true, "word": "ENTER", "clue": "To go in, or make an appearance on stage",},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false, 'active': true, "word": "ERROR", "clue": "A mistake made while typing or calculating",},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false, 'active': true, "word": "HALLS", "clue": "Long corridors or places for grand events",},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false, 'active': true, "word": "HANDS", "clue": "What you use to clap or pass things",},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false, 'active': true, "word": "HARDS", "clue": "Tough types or difficult situations",},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false, 'active': true, "word": "HATED", "clue": "Despised with strong feelings of dislike",},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false, 'active': true, "word": "HATER", "clue": "One who dislikes or criticizes everything",},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false, 'active': true, "word": "HATES", "clue": "Despises something with passion",},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false, 'active': true, "word": "RARER", "clue": "Less common or not often found",},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false, 'active': true, "word": "RATED", "clue": "Judged or given a score, like movies or performances",},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false, 'active': true, "word": "RATES", "clue": "Judgments or fees for services provided",},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false, 'active': true, "word": "RAZED", "clue": "Leveled to the ground, like an old building",},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false, 'active': true, "word": "RAZOR", "clue": "Sharp tool used for shaving",}
//       }
//     },
//     {
//       'level': 10,
//       'wheelData': {
//         "0": ['U', 'A', 'S', 'D', 'P'],
//         "1": ['U', 'I', 'M', 'E', 'A'],
//         "2": ['R', 'O', 'A', 'T', 'G'],
//         "3": ['U', 'I', 'A', 'E', 'S'],
//         "4": ['R', 'A', 'T', 'S', 'Y']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false, 'active': true, "word": "AEGIS", "clue": "Protection or sponsorship, often divine"},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false, 'active': true, "word": "AIRER", "clue": "Device for drying clothes, or a talk-show guest"},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false, 'active': true, "word": "AMASS", "clue": "Gather together, like a fortune or collection"},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false, 'active': true, "word": "AMOUR", "clue": "A romantic relationship, especially a secret one"},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false, 'active': true, "word": "AUGER", "clue": "Tool for drilling holes, often in wood or soil"},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false, 'active': true, "word": "AUGUR", "clue": "Ancient soothsayer or one who predicts the future"},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false, 'active': true, "word": "DARES", "clue": "Challenges to do something daring or risky"},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false, 'active': true, "word": "DATER", "clue": "Someone going out for romantic evenings"},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false, 'active': true, "word": "DATES", "clue": "Sweet fruits or calendar appointments"},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false, 'active': true, "word": "DETER", "clue": "Discourage or prevent through fear or doubt"},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false, 'active': true, "word": "DIGIT", "clue": "A number or a finger on your hand"},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false, 'active': true, "word": "PAGES", "clue": "Sheets in a book or young assistants in a castle"},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false, 'active': true, "word": "PATSY", "clue": "Someone easily blamed or tricked, a fall guy"},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false, 'active': true, "word": "PETER", "clue": "Common first name or a verb meaning to dwindle away"},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false, 'active': true, "word": "PETIT", "clue": "Small in size or minor in importance, often legal"},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false, 'active': true, "word": "PIOUS", "clue": "Devoutly religious or showing reverence"},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false, 'active': true, "word": "PURER", "clue": "More clean or less mixed with anything else"},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false, 'active': true, "word": "PURSY", "clue": "Short of breath or chubby, often after exertion"},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false, 'active': true, "word": "SIRES", "clue": "Fathers or male ancestors, especially of animals"},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false, 'active': true, "word": "SITAR", "clue": "Indian stringed instrument with a twangy sound"},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false, 'active': true, "word": "SITES", "clue": "Locations or web pages you visit"},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false, 'active': true, "word": "SITUS", "clue": "A property's location in legal terms"},
//         "22": {'key': 22, 'value': 5, 'hintOpen': false, 'active': true, "word": "SUGAR", "clue": "Sweet substance you stir into tea or coffee"},
//         "23": {'key': 23, 'value': 5, 'hintOpen': false, 'active': true, "word": "SURER", "clue": "More certain or confident in belief"}
//       }
//     },
//     {
//       'level': 11,
//       'wheelData': {
//         "0": ['R', 'B', 'C', 'S', 'L'],
//         "1": ['R', 'A', 'N', 'U', 'L'],
//         "2": ['B', 'V', 'A', 'P', 'E'],
//         "3": ['E', 'G', 'N', 'B', 'R'],
//         "4": ['E', 'S', 'L', 'K', 'M']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'active': true,"word": "BABEL", "clue": "A tower of confusion or many languages spoken at once"},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'active': true,"word": "BABES", "clue": "Infants, or affectionate term for significant others"},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'active': true,"word": "BLANK", "clue": "Empty or expressionless, like a stare or page"},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'active': true,"word": "BLARE", "clue": "Loud, harsh sound, like a trumpet or siren"},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'active': true,"word": "CAVES", "clue": "Underground chambers or gives in under pressure"},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'active': true,"word": "CLANK", "clue": "Loud metallic sound, like chains or heavy machinery"},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'active': true,"word": "CLANS", "clue": "Large family groups or Scottish tribes"},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'active': true,"word": "CLERK", "clue": "Office worker, or someone who checks you out at a store"},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'active': true,"word": "CRABS", "clue": "Pinching sea creatures with shells, or people in bad moods"},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'active': true,"word": "CRANE", "clue": "Long-necked bird or a machine for lifting heavy loads"},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'active': true,"word": "CRANK", "clue": "Handle you turn or a person with eccentric ideas"},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'active': true,"word": "CREEK", "clue": "Small stream flowing through the woods"},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'active': true,"word": "CREEL", "clue": "Basket used by fishermen to hold their catch"},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'active': true,"word": "CUBES", "clue": "Dice-shaped objects, or small blocks of ice"},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'active': true,"word": "CUPEL", "clue": "Tool used in metal refining, especially for precious metals"},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'active': true,"word": "LAPEL", "clue": "Folded part of a jacket near the collar"},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'active': true,"word": "RAVEL", "clue": "Untangle or complicate, like a mystery or thread"},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'active': true,"word": "RUPEE", "clue": "Currency of India and other South Asian countries"},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'active': true,"word": "SABRE", "clue": "A curved sword used in duels and cavalry charges"},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'active': true,"word": "SAVES", "clue": "Rescues from danger, or protects the goal in soccer"},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false,'active': true,"word": "SLABS", "clue": "Large flat pieces of stone, wood, or concrete"},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false,'active': true,"word": "SLAGS", "clue": "Byproducts of metal smelting, or insults directed at others"},
//         "22": {'key': 22, 'value': 5, 'hintOpen': false,'active': true,"word": "SLEEK", "clue": "Smooth, glossy, and well-groomed, often referring to hair or design"},
//         "23": {'key': 23, 'value': 5, 'hintOpen': false,'active': true,"word": "SNAGS", "clue": "Catches or obstacles that hold up progress"},
//         "24": {'key': 24, 'value': 5, 'hintOpen': false,'active': true,"word": "SNARE", "clue": "Trap for catching animals, or a type of drum"},
//         "25": {'key': 25, 'value': 5, 'hintOpen': false,'active': true,"word": "SNARK", "clue": "Biting or sarcastic commentary, often humorous"},
//         "26": {'key': 26, 'value': 5, 'hintOpen': false,'active': true,"word": "SNARL", "clue": "A tangle in hair or a growl from an angry animal"}
//       }  
//     },
//     {
//       'level': 12,
//       'wheelData': {
//         "0": ['M', 'S', 'H', 'F', 'O'],
//         "1": ['A', 'R', 'O', 'L', 'H'],
//         "2": ['L', 'H', 'I', 'B', 'T'],
//         "3": ['N', 'K', 'E', 'M', 'V'],
//         "4": ['S', 'K', 'L', 'E', 'T']
//       },
//       'clues': {
//         "0": {'key': 0, 'value': 5, 'hintOpen': false,'active': true, "word": "FAINT", "clue": "Lose consciousness or barely perceptible",},
//         "1": {'key': 1, 'value': 5, 'hintOpen': false,'active': true, "word": "FATES", "clue": "Mythical beings who control destiny, or unavoidable outcomes",},
//         "2": {'key': 2, 'value': 5, 'hintOpen': false,'active': true, "word": "FLIES", "clue": "Insects with wings or what time does when you're having fun",},
//         "3": {'key': 3, 'value': 5, 'hintOpen': false,'active': true, "word": "FLINT", "clue": "Hard stone used to spark fires in the wild",},
//         "4": {'key': 4, 'value': 5, 'hintOpen': false,'active': true, "word": "FOLKS", "clue": "People, often used to refer to family or friendly gatherings",},
//         "5": {'key': 5, 'value': 5, 'hintOpen': false,'active': true, "word": "FRIES", "clue": "Crispy potato sticks, often found next to burgers",},
//         "6": {'key': 6, 'value': 5, 'hintOpen': false,'active': true, "word": "HALVE", "clue": "Cut something into two equal parts",},
//         "7": {'key': 7, 'value': 5, 'hintOpen': false,'active': true, "word": "HATES", "clue": "Strong feelings of dislike",},
//         "8": {'key': 8, 'value': 5, 'hintOpen': false,'active': true, "word": "HOLES", "clue": "Openings or gaps in the ground, or a golf term",},
//         "9": {'key': 9, 'value': 5, 'hintOpen': false,'active': true, "word": "HOTEL", "clue": "Place to stay while traveling, with rooms and service",},
//         "10": {'key': 10, 'value': 5, 'hintOpen': false,'active': true, "word": "MAINS", "clue": "The principal parts of something, or central courses in a meal",},
//         "11": {'key': 11, 'value': 5, 'hintOpen': false,'active': true, "word": "MALES", "clue": "Men or boys in terms of gender",},
//         "12": {'key': 12, 'value': 5, 'hintOpen': false,'active': true, "word": "MATES", "clue": "Friends or partners, especially on a team or in life",},
//         "13": {'key': 13, 'value': 5, 'hintOpen': false,'active': true, "word": "MOLES", "clue": "Burrowing animals or spies within an organization",},
//         "14": {'key': 14, 'value': 5, 'hintOpen': false,'active': true, "word": "MOTEL", "clue": "Roadside place to stay for the night, often simpler than a hotel",},
//         "15": {'key': 15, 'value': 5, 'hintOpen': false,'active': true, "word": "MOTET", "clue": "Sacred choral composition, often heard in churches",},
//         "16": {'key': 16, 'value': 5, 'hintOpen': false,'active': true, "word": "OLIVE", "clue": "Small green or black fruit, often found in Mediterranean dishes",},
//         "17": {'key': 17, 'value': 5, 'hintOpen': false,'active': true, "word": "SAINT", "clue": "Holy person officially recognized by the church",},
//         "18": {'key': 18, 'value': 5, 'hintOpen': false,'active': true, "word": "SALES", "clue": "Discounts on goods or the process of selling items",},
//         "19": {'key': 19, 'value': 5, 'hintOpen': false,'active': true, "word": "SALVE", "clue": "Healing ointment or something that soothes",},
//         "20": {'key': 20, 'value': 5, 'hintOpen': false,'active': true, "word": "SHIES", "clue": "Becomes timid or avoids something",},
//         "21": {'key': 21, 'value': 5, 'hintOpen': false,'active': true, "word": "SHIMS", "clue": "Thin pieces of material used to align or support structures",},
//         "22": {'key': 22, 'value': 5, 'hintOpen': false,'active': true, "word": "SHINE", "clue": "Emit light or polish to a glossy finish",},
//         "23": {'key': 23, 'value': 5, 'hintOpen': false,'active': true, "word": "SHINS", "clue": "Front parts of your legs, or where you might get kicked",},
//         "24": {'key': 24, 'value': 5, 'hintOpen': false,'active': true, "word": "SHIVE", "clue": "A thin slice, often found in food prep or winemaking",},
//         "25": {'key': 25, 'value': 5, 'hintOpen': false,'active': true, "word": "SHIVS", "clue": "Homemade knives, often found in prison settings",},
//         "26": {'key': 26, 'value': 5, 'hintOpen': false,'active': true, "word": "SLIME", "clue": "Gooey, sticky substance often found in kids' play kits",},
//         "27": {'key': 27, 'value': 5, 'hintOpen': false,'active': true, "word": "SLIMS", "clue": "Becomes thinner or more slender",},
//         "28": {'key': 28, 'value': 5, 'hintOpen': false,'active': true, "word": "SLINK", "clue": "Move stealthily or sneak away unnoticed",},
//         "29": {'key': 29, 'value': 5, 'hintOpen': false,'active': true, "word": "SOLES", "clue": "Bottoms of feet or shoes, or flatfish in the sea",},
//         "30": {'key': 30, 'value': 5, 'hintOpen': false,'active': true, "word": "SOLVE", "clue": "Figure out a puzzle or find the answer",}
//       }
//     }
//   ];
// List<Map<dynamic,dynamic>> get levelData => _levelData;

}



















































































