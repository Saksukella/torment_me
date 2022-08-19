import 'package:get/get.dart';
import 'package:torment/models/leaderboard_model.dart';
import 'package:torment/services/auth.dart';
import 'package:torment/services/firebase_firestore.dart';
import 'package:torment/utils/leaderboard_utils.dart';

import '../resources/app_strings.dart';
import '../services/sharedPreferences.dart';

AuthService authService = Get.find();

class PointController extends GetxController {
  final _point = 0.obs;

  late final Rx<LeaderboardModel> _leaderboardModel =
      Rx<LeaderboardModel>(getRaw_leaderboard_Model());

  LeaderboardModel get getLeaderboardModel => _leaderboardModel.value;

  int getPoint() {
    if (authService.isSignIn) {
      return getLeaderboardModel.point;
    } else {
      return _point.value;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    if (authService.isSignIn) {
      _leaderboardModel.bindStream(Database().getUserStream());
    }
  }

  void addPoint(int point) {
    if (authService.isSignIn) {
      Database().update(getLeaderboardModel.copyWith(
        point: getLeaderboardModel.point + point,
      ));
    } else {
      _point.value += point;
    }
    AppSharedPreferences.saveInt(AppStrings.getPoint_KEY, _point.value);
  }

  //remove point

  void removePoint(int point) {
    if (authService.isSignIn) {
      Database().update(getLeaderboardModel.copyWith(
        point: getLeaderboardModel.point - point,
      ));
    } else {
      _point.value -= point;
    }
    AppSharedPreferences.saveInt(AppStrings.getPoint_KEY, _point.value);
  }

  void resetPoint() {
    if (authService.isSignIn) {
      Database().update(getLeaderboardModel.copyWith(
        point: 0,
      ));
    } else {
      _point.value = 0;
    }
    AppSharedPreferences.saveInt(AppStrings.getPoint_KEY, _point.value);
  }
}
