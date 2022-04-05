import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/notifications.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';




class NotificationBloc extends ChangeNotifier {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  

  bool? _subscribed;
  bool? get subscribed => _subscribed;

  int _notificationLength = 0;
  int get notificationLength => _notificationLength;
  
  int _savedNlength = 0;
  int get savedNlength => _savedNlength;

  int _notificationFinalLength = 0;
  int get notificationFinalLength => _notificationFinalLength;






  Future handleNotificationlength () async{
    await getNlengthFromSP().then((value){
      getNotificationLengthFromDatabase().then((_length){
        _notificationLength = _length;
        _notificationFinalLength = _notificationLength - savedNlength;
        notifyListeners();

      });
    });

  }



  Future<int> getNotificationLengthFromDatabase () async {
    final DocumentReference ref = firestore.collection('item_count').doc('notifications_count');
      DocumentSnapshot snap = await ref.get();
      if(snap.exists == true){
        int itemlength = snap['count'] ?? 0;
        return itemlength;
      }
      else{
        return 0;
      }
  }



  
  
  Future getNlengthFromSP () async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    int _savedLength = sp.get('saved length') as int? ?? 0;
    _savedNlength = _savedLength;
    notifyListeners();
  }


  Future saveNlengthToSP () async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('saved length', _notificationLength);
    _savedNlength = _notificationLength;
    handleNotificationlength();
    notifyListeners();
  }


  Future _handleIosNotificationPermissaion () async {
    NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
  }






  

  Future initFirebasePushNotification(context) async {
    if (Platform.isIOS) {
      _handleIosNotificationPermissaion();
    }
    handleFcmSubscribtion();
    String? _token = await _fcm.getToken();
    print('User FCM Token : $_token');

    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    print('inittal message : $initialMessage');
    if (initialMessage != null) {
      nextScreen(context, NotificationsPage());
    }
    

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      showinAppDialog(context, message.notification!.title, message.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      nextScreen(context, NotificationsPage());
    });
    notifyListeners();
  }






  Future handleFcmSubscribtion() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool _getsubcription = sp.getBool('subscribe') ?? true;
    if(_getsubcription == true){
      await sp.setBool('subscribe', true);
      _fcm.subscribeToTopic(Constants.fcmSubscriptionTopic);
      _subscribed = true;
      notifyListeners();
      print('subscribed');
    }else{
      await sp.setBool('subscribe', false);
      _fcm.unsubscribeFromTopic(Constants.fcmSubscriptionTopic);
      _subscribed = false;
      notifyListeners();
      print('unsubscribed');
    }
    
    notifyListeners();
  }








  Future fcmSubscribe(bool isSubscribed) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('subscribe', isSubscribed);
    handleFcmSubscribtion();
  }

  







  showinAppDialog(context, title, body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(title),
          subtitle: Text(
            HtmlUnescape().convert(parse(body).documentElement!.text),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              child: Text('Open'),
              onPressed: () {
                Navigator.of(context).pop();
                nextScreen(context, NotificationsPage());
              }),
        ],
      ),
    );
  }
}