import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';                      //admob ads
//import 'package:facebook_audience_network/facebook_audience_network.dart';    //fb ads
import 'package:news_app/config/ad_config.dart';

class AdsBloc extends ChangeNotifier {

  bool? _bannerAdEnabled = false;
  bool? get bannerAdEnabled => _bannerAdEnabled;

  bool? _interstitialAdEnabled = false;
  bool? get interstitialAdEnabled => _interstitialAdEnabled;

  bool _isAdLoaded = false;
  bool get isAdLoaded => _isAdLoaded;

  Future checkAdsEnable() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('admin')
        .doc('ads')
        .get()
        .then((DocumentSnapshot snap) {
      bool? _banner = snap['banner_ad'];
      bool? _interstitial = snap['interstitial_ad'];
      _bannerAdEnabled = _banner;
      _interstitialAdEnabled = _interstitial;
      print('banner : $_bannerAdEnabled, interstitial: $_interstitialAdEnabled');
      notifyListeners();
    }).catchError((e) {
      print('error : $e');
    });
  }

  //enable only one
  Future initiateAds ()async{
    await MobileAds.instance.initialize();  //admob
    //await FacebookAudienceNetwork.init();  //fb
  }


  //enbale only one
  void loadAds (){
    createInterstitialAdAdmob();  //admob
    //createInterstitialAdFb(); //fb
  }


  //enbale only one
  @override
  void dispose() {
    interstitialAdAdmob?.dispose();  //admob
    //disposefbInterstitial();       //fb
    super.dispose();
  }




  // Admob Ads -- START --

  InterstitialAd? interstitialAdAdmob;

  void createInterstitialAdAdmob() {
    InterstitialAd.load(
        adUnitId: AdConfig().getAdmobInterstitialAdUnitId(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAdAdmob = ad;
            _isAdLoaded = true;
            notifyListeners();
            showInterstitialAdAdmob();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            interstitialAdAdmob = null;
            _isAdLoaded = false;
            notifyListeners();
          },
        ));
  }


  void showInterstitialAdAdmob() {
    if(interstitialAdAdmob != null){

      interstitialAdAdmob!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        interstitialAdAdmob = null;
        _isAdLoaded = false;
        notifyListeners();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        interstitialAdAdmob = null;
        _isAdLoaded = false;
        notifyListeners();
      },
      );
      interstitialAdAdmob!.show();
      interstitialAdAdmob = null;
      notifyListeners();
    }
  }


  // Admob Ads -- END --






  


  // Fb Ads -- START --

  // void createInterstitialAdFb() {
  //   FacebookInterstitialAd.loadInterstitialAd(
  //     placementId: AdConfig().getFbInterstitialAdUnitId(),
  //     listener: (result, value) {
  //       print('ad result : $result');
  //       if (result == InterstitialAdResult.LOADED){
  //         _isAdLoaded = true;
  //         debugPrint('ads loaded');
  //         notifyListeners();
  //         showInterstitialAdFb();
  //       }else if(result == InterstitialAdResult.DISMISSED && value["invalidated"] == true){
  //         _isAdLoaded = false;
  //         notifyListeners();
  //         debugPrint('ads dismissed or error : $result');
  //       }
  //     }
  //   );
  // }


  // void showInterstitialAdFb() async{
  //   await FacebookInterstitialAd.showInterstitialAd();
  //   _isAdLoaded = false;
  //   notifyListeners();
  // }

  

  // Future disposefbInterstitial()async {
  //   if (_isAdLoaded == true) {
  //     FacebookInterstitialAd.destroyInterstitialAd();
  //     _isAdLoaded = false;
  //     notifyListeners();
  //   }
  // }


  // Fb Ads -- END --
}
