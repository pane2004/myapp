import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  ///Reads name from user document
  Future<String> getName() async {
    var ref = _db.collection('users').doc(firebaseUser!.uid);
    var snapshot = await ref.get();
    return snapshot.data()!["displayName"];
  }

  ///Reads scans from user document
  Future<String> scanCount() async {
    var ref = _db.collection('users').doc(firebaseUser!.uid);
    var snapshot = await ref.get();
    return snapshot.data()!["scanCount"].toString();
  }

  ///Reads joinDate from user document
  Future<String> joinDate() async {
    var ref = _db.collection('users').doc(firebaseUser!.uid);
    var snapshot = await ref.get();
    return snapshot.data()!["joinDate"];
  }

  ///Deletes all scan documents from user subcollection
  Future<void> clearScans() async {
    var snapshots = await _db
        .collection('users')
        .doc(firebaseUser!.uid)
        .collection('scans')
        .get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  ///Updates Users Display Name
  changeName(String name) {
    _db
        .collection('users')
        .doc(firebaseUser!.uid)
        .update({"displayName": name});
  }

  ///Updates Users Carbon Amount
  resetCarbon() {
    _db.collection('users').doc(firebaseUser!.uid).update({"carbon": 0});
  }

  /// Reads all documments from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  /// Reads all documments from the topics collection
  Future<List<Scan>> getScans() async {
    var ref =
        _db.collection('users').doc(firebaseUser!.uid).collection('scans');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var scans = data.map((d) => Scan.fromJson(d));
    return scans.toList();
  }

  /// Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  /// Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  /// Updates the current user's report document after completing quiz
  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id])
      }
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
