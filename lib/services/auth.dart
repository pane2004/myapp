import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:myapp/services/firestore.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  ///Anonymous Firebase Login
  Future<void> anonLogin() async {
    DateTime today = DateTime.now();
    String date = today.toString().substring(0, 10);
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      //Handle Error
    } finally {
      var newFirebaseUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('users')
          .doc(newFirebaseUser?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
        } else {
          firestoreInstance.collection("users").doc(newFirebaseUser?.uid).set({
            "displayName": "Guest User",
            "carbon": 0,
            "scanCount": 0,
          }).then((_) {
            firestoreInstance
                .collection('users')
                .doc(newFirebaseUser?.uid)
                .collection('scans')
                .add({
              "img":
                  "https://firebasestorage.googleapis.com/v0/b/projecttest-f77b1.appspot.com/o/icon%20(1).png?alt=media&token=4c6feb3d-a2d2-4b05-8326-cc013a6544f7",
              "classification": "My First Scan",
              "time": date
            });
          });
        }
      });
    }
  }

  ///Firebase Logout
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  ///Google Firebase Login
  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      //Handle Error
    } finally {
      var newFirebaseUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('users')
          .doc(newFirebaseUser?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
        } else {
          firestoreInstance.collection("users").doc(newFirebaseUser?.uid).set({
            "displayName": "Guest User",
            "carbon": 0,
            "scanCount": 0,
            "Location": "Greater Toronto Area"
          });
        }
      });
    }
  }

  ///Apple Firebase Login
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
