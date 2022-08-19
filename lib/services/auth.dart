import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:torment/models/leaderboard_model.dart';
import 'package:torment/services/firebase_firestore.dart';
import 'package:torment/simple_widgets/snackbar.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firebaseUser = FirebaseAuth.instance.currentUser.obs;

  LeaderboardModel? _leaderboardModel;

  User? get getUser => _firebaseUser.value;

  bool get isSignIn => _firebaseUser.value != null;

  LeaderboardModel? get getLeaderboardModel => _leaderboardModel;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  //signout

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> googleSignIn() async {
    try {
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();
      if (account == null) return "Something went wrong";

      final GoogleSignInAuthentication authentication =
          await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      await _auth.signInWithCredential(credential);
      await Database().signInUploadLocalData();
      return null;
    } on FirebaseAuthException catch (e) {
      log(e.message ?? "");
      showSnackbar(e.message ?? 'Error');
      return e.message;
    } catch (e) {
      showSnackbar(e.toString());
      return e.toString();
    }
  }
}
