import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:torment/models/leaderboard_model.dart';
import 'package:torment/services/auth.dart';
import 'package:torment/utils/leaderboard_utils.dart';

class Database {
  late DocumentReference userCollection;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Database() {
    AuthService authService = Get.find();
    userCollection =
        _firestore.collection('users').doc(authService.getUser!.uid);
  }
  //create update

  //get data
  Future<LeaderboardModel> getLeaderboardModel() async {
    final snapshot = await userCollection.get();
    LeaderboardModel leaderboardModel =
        LeaderboardModel.fromMap(snapshot.data() as Map<String, dynamic>);
    return leaderboardModel;
  }

  Future<void> createUpdate(LeaderboardModel model) async {
    await userCollection.set(model.toMap());
  }

  //update
  Future<void> update(LeaderboardModel model) async {
    await userCollection.update(model.toMap());
  }

  Future<void> signInUploadLocalData() async {
    AuthService authService = Get.find();
    userCollection.get().then((value) async {
      if (!value.exists) {
        await createUpdate(getRaw_leaderboard_Model());
      }
    });
  }

  Stream<List<LeaderboardModel>> getLeaderboardStream() {
    return _firestore
        .collection('users')
        .orderBy('point', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return LeaderboardModel.fromMap(doc.data());
            }).toList());
  }

  Stream<LeaderboardModel> getUserStream() {
    return userCollection.snapshots().map((snapshot) {
      return LeaderboardModel.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }
}
