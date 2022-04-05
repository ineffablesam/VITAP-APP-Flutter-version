import 'package:flutter/material.dart';
import 'package:news_app/config/ad_config.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class BannerAdFb extends StatelessWidget {
  const BannerAdFb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FacebookBannerAd(
      placementId: AdConfig().getFbBannerAdUnitId(),
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print('fb banner : $result');
      },
    );
  }
}
