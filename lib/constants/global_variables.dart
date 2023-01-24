import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String uri = 'https://halved-button-editor.glitch.me';
// String uri = 'http://192.168.43.148:3000'; try now

// String uri = 'http://10.0.2.35:3000';

//String uri = 'http://10.0.2.2:3000'; // yeh emulator ka local host h

toaster(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 190, 222, 49),
      Color.fromARGB(255, 175, 190, 36),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 190, 222, 49);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static const selectedNavBarColor = Color.fromARGB(255, 190, 222, 49);
  static const unselectedNavBarColor = Colors.black87;


  // STATIC IMAGES
  static const List<String> carouselImages = [
    // 'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    // 'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    
    "assets/images/MEGA.png",
    "assets/images/MEGA.png",
    "assets/images/MEGA.png",
    "assets/images/MEGA.png",
    "assets/images/MEGA.png",
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Bags',
      'image': 'assets/images/pk_bag.jpg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/pk_dress.jpg',
    },
    {
      'title': 'Crockery',
      'image': 'assets/images/pk_pot.jpg',
    },
    {
      'title': 'Shoes',
      'image': 'assets/images/pk_sandal.png',
    },
    {
      'title': 'Jewellery',
      'image': 'assets/images/pk_jewellery.jpg',
    },
  ];
}
