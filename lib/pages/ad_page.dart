import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:torment/adService/adState.dart';
import 'package:torment/controllers/point.dart';
import 'package:torment/simple_widgets/margin.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key});

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  final List<Widget> adList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AdState adState = Provider.of(context);
    for (var i = 0; i < 10; i++) {
      adState.createBannerAd().then((ad) {
        adList.add(SizedBox(
          height: ad.size.height.toDouble(),
          child: AdWidget(ad: ad),
        ));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PointController pointController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "15 Torment Point per Click",
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            addVerticalMargin(15),
            Obx(() {
              return Align(
                alignment: Alignment.center,
                child: Text(
                  "Torment Points = ${pointController.getPoint()}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.orange.shade500),
                ),
              );
            }),
            addVerticalMargin(20),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: adList.length,
              itemBuilder: (context, index) {
                return adList.elementAt(index);
              },
            ),
          ],
        ));
  }
}
