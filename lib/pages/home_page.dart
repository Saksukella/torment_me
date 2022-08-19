import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:torment/controllers/point.dart';
import 'package:torment/pages/ad_page.dart';
import 'package:torment/resources/app_strings.dart';
import 'package:torment/services/sharedPreferences.dart';
import 'package:torment/simple_widgets/snackbar.dart';
import 'package:torment/utils/animations_list.dart';

import '../adService/adState.dart';
import '../simple_widgets/margin.dart';
import '../widgets/drawer.dart';
import '../widgets/leaderboard.dart';
import '../widgets/rounded_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenWidth = Get.width;
  BannerAd? _bannerAd;
  late AdState adState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    adState = Provider.of<AdState>(context);
    adState.initializationStatus.then((value) {
      setState(() {
        _bannerAd = BannerAd(
            size: AdSize.banner,
            adUnitId: adState.bannerUnitID(),
            listener: adState.getBannerAdListener,
            request: const AdRequest())
          ..load();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  PointController pointController = Get.put(PointController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int point = pointController.getPoint();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Torment App"),
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            addVerticalMargin(10),
            const getWidget_leaderboard(),
            addVerticalMargin(
              5,
            ),
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Obx(() {
                    var animationUrl = AppSharedPreferences.getString(
                            AppStrings.getAnimationUrl_KEY)
                        .obs;
                    return Container(
                        height: Get.height * 0.35,
                        padding: const EdgeInsets.all(10),
                        child: Card(
                            child: animationUrl.value == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "No Animation , No Happiness",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      addVerticalMargin(15),
                                      ElevatedButton(
                                        child: const Text(
                                            "Get Random Animation -75TP"),
                                        onPressed: () {
                                          getRandomAnimation(animationUrl);
                                        },
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _LottieWidget(animationUrl: animationUrl),
                                      Expanded(
                                          flex: 2,
                                          child: TextButton(
                                            onPressed: () {
                                              getRandomAnimation(animationUrl);
                                            },
                                            child: const Text(
                                                "Switch Animation - 75TP"),
                                          ))
                                    ],
                                  )));
                  }),
                  addVerticalMargin(10),
                  Row(
                    children: [
                      const Text("+15"),
                      addHorizontalMargin(10),
                      Expanded(
                        child: RoundedButton(
                            pressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AdPage()));
                              return true;
                            },
                            text: "Show me List of Ads :(",
                            color: Colors.green.shade300),
                      ),
                    ],
                  ),
                  addVerticalMargin(20),
                  Row(
                    children: [
                      const Text("+35"),
                      addHorizontalMargin(10),
                      Expanded(
                        child: RoundedButton(
                            pressed: () async {
                              await adState.showRewaredInterstitialAd();
                              return true;
                            },
                            text: "This is bad very bad",
                            color: Colors.green),
                      ),
                    ],
                  ),
                  addVerticalMargin(20),
                  Row(
                    children: [
                      const Text("+50"),
                      addHorizontalMargin(10),
                      Expanded(
                        child: RoundedButton(
                            pressed: () async {
                              await adState.showRewardedAdDefault();
                              return true;
                            },
                            text: "you can do it",
                            color: Colors.yellow.shade900),
                      ),
                    ],
                  ),
                  addVerticalMargin(20),
                  Row(
                    children: [
                      const Text("+100"),
                      addHorizontalMargin(10),
                      Expanded(
                        child: RoundedButton(
                            pressed: () async {
                              await adState.showRewardedAd("mobile", "game");
                              return true;
                            },
                            text: "Show me wierdest mobile game ad",
                            color: Colors.red.shade500),
                      ),
                    ],
                  ),
                  addVerticalMargin(20)
                ],
              ),
            ),
            if (_bannerAd == null)
              const SizedBox(
                height: 50,
              )
            else
              Container(
                color: Colors.red,
                height: 50,
                child: AdWidget(ad: _bannerAd!),
              )
          ],
        ),
      );
    });
  }

  void getRandomAnimation(Rx<String?> animationUrl) {
    PointController pointController = Get.find();
    if (pointController.getPoint() >= 75) {
      pointController.removePoint(75);
      animationUrl.value = getRandomUrl();
      AppSharedPreferences.saveString(
          AppStrings.getAnimationUrl_KEY, animationUrl.value!);
    } else {
      showSnackbar("You are broke GET SOME TP");
    }
  }
}

class _LottieWidget extends StatefulWidget {
  const _LottieWidget({
    Key? key,
    required this.animationUrl,
  }) : super(key: key);

  final Rx<String?> animationUrl;

  @override
  State<_LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<_LottieWidget> {
  bool animate = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: GestureDetector(
                onTap: () {
                  animate = !animate;
                  setState(() {});
                },
                child: Lottie.network(
                  widget.animationUrl.value!,
                  animate: animate,
                  repeat: true,
                  frameRate: FrameRate.max,
                ),
              ),
            ),
            addVerticalMargin(3),
          ],
        ));
  }
}
