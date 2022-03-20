import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/provider/registration.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
    User user = result.user!;

    DatabaseService(uid: user.uid).updateUserData(user.displayName!);
    notifyListeners();

  }

  Future logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}