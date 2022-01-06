// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/services/models.dart';
import 'package:myapp/shared/bottom_nav.dart';
import 'package:myapp/shared/loading.dart';
import 'package:myapp/shared/error.dart';
import 'package:myapp/topics/topic_item.dart';
import 'package:myapp/topics/tool_item.dart';
import 'package:myapp/topics/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  "https://i.ibb.co/cJcrhXF/big-o-chart-tutorial-bazar-aymptotic-notations-1.png",
  "https://i.ibb.co/mvzZBJS/588b4949713ba11c008b4e37.jpg",
  "https://i.ibb.co/MBnfkjm/thehistoryan.jpg",
];

final List<String> toolList = [
  "My Carbon Savings",
  "Local Waste Depots",
  "Pickup Schedule",
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.only(right: 30),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 800,
                  ),
                ],
              )),
        ))
    .toList();

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            backgroundColor: const Color(0xFFF9FCFF),
            drawer: const TopicDrawer(),
            // ignore: prefer_const_literals_to_create_immutables
            body: CustomScrollView(slivers: <Widget>[
              const TopBar(),
              const Tools(),
              ScanHistory(topics: topics),
            ]),

            ///Floating Navbar
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.camera_alt_rounded),
              onPressed: () {},
              backgroundColor: const Color(0xFF84C879),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics in Firestore. Check Database');
        }
      },
    );
  }
}

class ScanHistory extends StatelessWidget {
  const ScanHistory({
    Key? key,
    required this.topics,
  }) : super(key: key);

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(left: 25, top: 10),
        child: Text(
          "Scan History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      GridView.count(
        mainAxisSpacing: 10,
        childAspectRatio: 4,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisCount: 1,
        children: topics
            .map((topic) => TopicItem(
                  topic: topic,
                ))
            .toList(),
      ),
    ]));
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: const Color(0xFF84C879),
      shape: const ContinuousRectangleBorder(
          borderRadius: const BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              bottomRight: Radius.circular(50))),
      snap: false,
      pinned: true,
      floating: false,
      expandedHeight: 240.0,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1.0,
                child: Text(top > 64 && top < 249 ? "" : "WasteWizard++"),
              );
            },
          ),
          background: Container(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    "Recommended Reads",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 125,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                )
              ],
            ),
          )),
    );
  }
}

class Tools extends StatelessWidget {
  const Tools({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 25, top: 10),
          child: Text(
            "Tools",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          children: toolList
              .map((tool) => ToolItem(
                    tool: tool,
                    title: tool,
                  ))
              .toList(),
        )
      ]),
    );
  }
}
