import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torment/controllers/leaderboard.dart';
import 'package:torment/models/leaderboard_model.dart';
import 'package:torment/simple_widgets/margin.dart';

class listItem_leaderboard extends StatelessWidget {
  const listItem_leaderboard({super.key, required this.leaderboardModel});

  final LeaderboardModel leaderboardModel;

  @override
  Widget build(BuildContext context) {
    LeaderboardController leaderboardController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "RANK : ${leaderboardController.getUserIndexInList(leaderboardModel) + 1}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          addVerticalMargin(5),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(leaderboardModel.photoUrl ??
                  "https://t3.ftcdn.net/jpg/02/59/39/46/240_F_259394679_GGA8JJAEkukYJL9XXFH2JoC3nMguBPNH.jpg"),
            ),
            title: Text(leaderboardModel.name ?? "Untitled"),
            subtitle: Text(leaderboardModel.email ?? "Untitled"),
            trailing: Text(
              "TP : ${leaderboardModel.point}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.orange.shade500),
            ),
          ),
          addVerticalMargin(5),
          Text("${leaderboardModel.loginDate}"),
        ],
      ),
    );
  }
}
