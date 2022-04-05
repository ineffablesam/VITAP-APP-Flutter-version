import 'package:flutter/material.dart';

class Config {
  final String appName = 'YOUR_APP_NAME';
  final String splashIcon = 'assets/images/splash.png';
  final String splashIconMain = 'assets/images/splashicon.png';
  final String supportEmail = 'YOUR_EMAIL';
  final String privacyPolicyUrl = 'https://csivitap.co.in/privacy-policy';
  final String ourWebsiteUrl = 'https://csivitap.co.in/';
  final String iOSAppId = '000000';

  //social links
  static const String facebookPageUrl = 'https://www.facebook.com/mrblab24';
  static const String youtubeChannelUrl =
      'https://www.youtube.com/channel/UCnNr2eppWVVo-NpRIy1ra7A';
  static const String twitterUrl = 'https://twitter.com/FlutterDev';

  //app theme color
  final Color appColor = Colors.deepPurpleAccent;

  //Intro images
  final String introImage1 = 'assets/images/news1.png';
  final String introImage2 = 'assets/images/news6.png';
  final String introImage3 = 'assets/images/news7.png';

  //animation files
  final String doneAsset = 'assets/animation_files/done.json';

  //Language Setup
  final List<String> languages = ['English', 'Spanish', 'Arabic'];

  //initial categories - 4 only (Hard Coded : which are added already on your admin panel)
  final List initialCategories = [
    'Entertainment',
    'Sports',
    'Politics',
    'Travel'
  ];
}
