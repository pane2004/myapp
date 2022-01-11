// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/services/firestore.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WasteWizard++ Settings"),
        backgroundColor: const Color(0xFF84C879),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("ALERT: All Setting Buttons are irreversible!"),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    FirestoreService().clearScans();
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(250, 80)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF84C879)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: const Color(0xFF84C879)))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever,
                        size: 35,
                      ),
                      Text(
                        "Delete Scan History",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    FirestoreService().resetCarbon();
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(250, 80)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF84C879)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: const Color(0xFF84C879)))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restart_alt,
                        size: 35,
                      ),
                      Text(
                        "Reset Carbon Savings",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  'assets/logolong.png',
                  width: 400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
