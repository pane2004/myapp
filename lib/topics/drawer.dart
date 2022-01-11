// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/firestore.dart';
import 'package:provider/provider.dart';
import 'package:myapp/quiz/quiz.dart';
import 'package:myapp/services/models.dart';

class TopicDrawer extends StatefulWidget {
  final String name;
  const TopicDrawer({Key? key, required this.name}) : super(key: key);

  @override
  State<TopicDrawer> createState() => _TopicDrawerState();
}

class _TopicDrawerState extends State<TopicDrawer> {
  late TextEditingController controller;
  String newName = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Image.asset(
                  'assets/logolong.png',
                  width: 250,
                )),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: Row(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF84C879),
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    color: Color(0xFF84C879),
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final newName = await openPopup();
                      if (newName == null || newName.isEmpty) return;

                      setState(() => this.newName = newName);
                      FirestoreService().changeName(newName);
                    },
                  )
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 60,
            ),
            SideBar(
              title: "Statistics",
              icon: Icons.query_stats,
              page: '/statistics',
            ),
            SideBar(
              title: "Notifications",
              icon: Icons.notifications_active,
              page: '/noti',
            ),
            SideBar(
              title: "History",
              icon: Icons.history,
              page: '/scanHistory',
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 60,
            ),
            SideBar(
              title: "Settings",
              icon: Icons.settings,
              page: '/settings',
            ),
            SideBar(
              title: "Privacy Policy",
              icon: Icons.privacy_tip,
              page: '/privacy',
            ),
            SideBar(
              title: "Help Centre",
              icon: Icons.help,
              page: '/help',
            ),
            InkWell(
              onTap: () async {
                await AuthService().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text("Sign Out"),
                  leading: Icon(Icons.logout),
                  iconColor: const Color(0xFF84C879),
                ),
              ),
            )
          ],
        ),
      );

  Future<String?> openPopup() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "Change Display Name",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            content: TextField(
              cursorColor: const Color(0xFF84C879),
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter your name",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF84C879)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF84C879)),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFF84C879)),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text);
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: const Color(0xFF84C879),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                style:
                    TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ));
}

class SideBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final String page;

  const SideBar({
    Key? key,
    required this.title,
    required this.icon,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, page);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
          iconColor: const Color(0xFF84C879),
        ),
      ),
    );
  }
}
