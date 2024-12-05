import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/job_detail_screen.dart';

class AdmobServices {
   RewardedAd? rewardedAd;
   InterstitialAd? interstitialAd;

  //open Mail in mobile
  void _contactEmail(String email) async {
    final url = Uri.parse('mailto:$email');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }

  }

  // open phone number in mobile
  void _contactPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void loadRewardAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          rewardedAd!.dispose();
          loadRewardAd();
        }));
  }

   void loadRewardAdEmail(String email,BuildContext context) {
     RewardedAd.load(
         adUnitId: 'ca-app-pub-3940256099942544/5224354917',
         request: const AdRequest(),
         rewardedAdLoadCallback:
         RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
           rewardedAd = ad;
           Navigator.of(context).pop();
           showRewardedAd(email);
         }, onAdFailedToLoad: (LoadAdError error) {
           rewardedAd!.dispose();
           loadRewardAd();
         }));
   }

   void loadRewardAdPhoneNumber(String phoneNumber,BuildContext context) {
     RewardedAd.load(
         adUnitId: 'ca-app-pub-3940256099942544/5224354917',
         request: const AdRequest(),
         rewardedAdLoadCallback:
         RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
           rewardedAd = ad;
           Navigator.of(context).pop();
           showRewardedAdPhone(phoneNumber);
         }, onAdFailedToLoad: (LoadAdError error) {
           rewardedAd!.dispose();
           loadRewardAd();
         }));
   }

  void showRewardedAd(String email) {
    rewardedAd?.show(onUserEarnedReward: (RewardedAd, RewardItem) {
      print('asd');
    });
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {

        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _contactEmail(email);
          loadRewardAd();
        });
  }

  void showRewardedAdPhone(String phoneNumber) {
    rewardedAd?.show(onUserEarnedReward: (RewardedAd, RewardItem) {
      print('asd');
    });
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {},
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _contactPhoneNumber(phoneNumber);
          loadRewardAd();
        });
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          interstitialAd!.dispose();
          loadRewardAd();
        }));
  }

  void loadInterstitialAd1(int id, BuildContext context,int index) {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback:
        InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          showInterstitialAd(id, context, index);
        }, onAdFailedToLoad: (LoadAdError error) {
          interstitialAd!.dispose();
          loadRewardAd();
        }));

  }

  void showInterstitialAd(int id, BuildContext context,int index) {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => JobDetailScreen(
              id: id,
              index: index,
            ),
          ));
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          loadInterstitialAd();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
  }
}
