import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/point.dart';

class AdState {
  final Future<InitializationStatus> initializationStatus;

  final int maxFailedLoadAttempts = 5;

  final AdRequest request = const AdRequest();

  AdState(this.initializationStatus);
  BannerAdListener get getBannerAdListener => _bannerAdListener;

  String bannerUnitID() {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      if (GetPlatform.isAndroid) {
        return "ca-app-pub-7475584191732633/4979586989";
      } else {
        return "ca-app-pub-3940256099942544~3347511713";
      }
    }
  }

  String rewaredInterUnitID() {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/5354046379';
    } else {
      if (GetPlatform.isAndroid) {
        return "ca-app-pub-7475584191732633/4769572108";
      } else {
        return "ca-app-pub-3940256099942544~3347511713";
      }
    }
  }

  String rewaredUnitID() {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else {
      if (GetPlatform.isAndroid) {
        return "ca-app-pub-7475584191732633/6497586741";
      } else {
        return "ca-app-pub-3940256099942544~3347511713";
      }
    }
  }

  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdOpened: (ad) {
      log("onAdOpened");
    },
    onAdClicked: (ad) {
      log("banner ad clicked");
      PointController pointController = Get.find();
      pointController.addPoint(15);
      ad.dispose();
    },
  );

  Future<BannerAd> createBannerAd() async {
    BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        request: const AdRequest(),
        adUnitId: bannerUnitID(),
        listener: _bannerAdListener);
    await bannerAd.load();
    return bannerAd;
  }

  Future<void> showRewaredInterstitialAd({int loadAttempt = 0}) async {
    await RewardedInterstitialAd.load(
      adUnitId: rewaredInterUnitID(),
      request: request,
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd rewardedInterstitialAd) {
          rewardedInterstitialAd.setImmersiveMode(true);
          rewardedInterstitialAd.show(
            onUserEarnedReward: (ad, reward) {
              int amount = 35;
              PointController pointController = Get.find();
              pointController.addPoint(amount);
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          loadAttempt += 1;

          if (loadAttempt < maxFailedLoadAttempts) {
            showRewaredInterstitialAd(loadAttempt: loadAttempt);
          }
        },
      ),
    );
  }

  Future<void> showRewardedAd(String key0, String key1,
      {int loadAttempt = 0}) async {
    await RewardedAd.load(
        adUnitId: rewaredUnitID(),
        request: AdRequest(
          keywords: [key0, key1],
        ),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            ad.setImmersiveMode(true);
            ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              int amount = 100;
              PointController pointController = Get.find();
              pointController.addPoint(amount);
              ad.dispose();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            loadAttempt += 1;
            if (loadAttempt < maxFailedLoadAttempts) {
              showRewardedAd(key0, key1, loadAttempt: loadAttempt);
            }
          },
        ));
  }

  Future<void> showRewardedAdDefault({int loadAttempt = 0}) async {
    await RewardedAd.load(
        adUnitId: rewaredUnitID(),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            ad.setImmersiveMode(true);
            ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              int amount = 50;
              PointController pointController = Get.find();
              pointController.addPoint(amount);
              ad.dispose();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            loadAttempt += 1;
            if (loadAttempt < maxFailedLoadAttempts) {
              showRewardedAdDefault(loadAttempt: loadAttempt);
            }
          },
        ));
  }
}
