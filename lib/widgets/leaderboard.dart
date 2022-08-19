import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torment/controllers/point.dart';
import 'package:torment/services/auth.dart';
import 'package:torment/simple_widgets/margin.dart';
import 'package:torment/widgets/rounded_button.dart';

import '../pages/leaderboard.dart';

class getWidget_leaderboard extends StatelessWidget {
  const getWidget_leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.find();
    PointController pointController = Get.find();
    return Obx(() {
      int point = pointController.getPoint();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      const Text("Torment Points"),
                      addVerticalMargin(5),
                      Text(
                        point.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Expanded(
                    flex: 3,
                    child: authService.isSignIn
                        ? TextButton(
                            onPressed: () {
                              Get.to(const LeaderBoardPage());
                            },
                            child: const Text("Leaderboard"))
                        : RoundedButton(
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            width: 130,
                            pressed: () async {
                              String? error = await authService.googleSignIn();
                              return error == null ? true : false;
                            },
                            text: "Sign in",
                            color: Colors.redAccent),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
