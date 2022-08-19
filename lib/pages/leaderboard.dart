import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torment/controllers/leaderboard.dart';
import 'package:torment/controllers/point.dart';
import 'package:torment/listItems/leaderboard_listItem.dart';
import 'package:torment/simple_widgets/margin.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    LeaderboardController leaderboardController =
        Get.put(LeaderboardController());
    PointController pointController = Get.find();
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Leaderboard"),
          ),
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Text(
                "Say hello to your leaderboard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              addVerticalMargin(10),
              Card(
                child: Column(
                  children: [
                    listItem_leaderboard(
                        leaderboardModel: pointController.getLeaderboardModel)
                  ],
                ),
              ),
              addVerticalMargin(5),
              const Divider(
                height: 2,
              ),
              addVerticalMargin(8),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Leaderboard",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              addVerticalMargin(8),
              Card(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return listItem_leaderboard(
                        leaderboardModel:
                            leaderboardController.getLeaderboard[index]);
                  },
                  itemCount: leaderboardController.getLeaderboard.length,
                ),
              )
            ],
          ));
    });
  }
}
