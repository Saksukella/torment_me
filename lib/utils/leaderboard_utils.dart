import 'package:get/get.dart';
import 'package:torment/models/leaderboard_model.dart';
import 'package:torment/services/auth.dart';
import 'package:torment/services/sharedPreferences.dart';

import '../resources/app_strings.dart';

LeaderboardModel getRaw_leaderboard_Model() {
  AuthService authService = Get.find();
  if (authService.isSignIn) {
    return LeaderboardModel(
      uid: authService.getUser!.uid,
      point: AppSharedPreferences.getInt(AppStrings.getPoint_KEY) ?? 0,
      name: authService.getUser!.displayName,
      photoUrl: authService.getUser!.photoURL,
      loginDate: DateTime.now(),
    );
  } else {
    return LeaderboardModel(
      uid: "0",
      point: 0,
      name: "Loading...",
      photoUrl: "",
      loginDate: DateTime.now(),
    );
  }
}
