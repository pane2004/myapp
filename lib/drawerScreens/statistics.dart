// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/shared/error.dart';
import 'package:myapp/shared/loading.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Statistics"),
        backgroundColor: const Color(0xFF84C879),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: AvatarView(
                radius: 60,
                borderWidth: 5,
                borderColor: const Color(0xFF84C879),
                avatarType: AvatarType.CIRCLE,
                imagePath: "assets/wizard.png",
                placeHolder: Icon(
                  Icons.person,
                  size: 50,
                ),
                errorWidget: Icon(
                  Icons.error,
                  size: 50,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: nameFetch(),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.calendar_today,
                      size: 40,
                    ),
                  ),
                  Text(
                    "Join Date:",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: dateFetch(),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 45,
                  ),
                  Text(
                    "Total Scans:",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: scanFetch(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<String> nameFetch() {
    return FutureBuilder<String>(
        future: FirestoreService().getName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var name = snapshot.data!;
            return Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return const Text('Check Database');
          }
        });
  }

  FutureBuilder<String> scanFetch() {
    return FutureBuilder<String>(
        future: FirestoreService().scanCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var name = snapshot.data!;
            return Text(
              name,
              style: TextStyle(
                fontSize: 36,
                color: const Color(0xFF84C879),
              ),
            );
          } else {
            return const Text('Check Database');
          }
        });
  }

  FutureBuilder<String> dateFetch() {
    return FutureBuilder<String>(
        future: FirestoreService().joinDate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var name = snapshot.data!;
            return Text(
              name,
              style: TextStyle(
                fontSize: 30,
                color: const Color(0xFF84C879),
              ),
            );
          } else {
            return const Text('Check Database');
          }
        });
  }
}
