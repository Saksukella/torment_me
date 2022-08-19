import 'package:get/get.dart';
import 'package:torment/models/leaderboard_model.dart';
import 'package:torment/services/firebase_firestore.dart';

class LeaderboardController extends GetxController {
  final RxList<LeaderboardModel> _leaderboard = RxList<LeaderboardModel>();

  List<LeaderboardModel> get getLeaderboard => _leaderboard.value;

  int getUserIndexInList(LeaderboardModel leaderboardModel) {
    if (leaderboardModel == null) {
      return -1;
    } else {
      return getLeaderboard.indexOf(leaderboardModel);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _leaderboard.bindStream(Database().getLeaderboardStream());
  }
}
