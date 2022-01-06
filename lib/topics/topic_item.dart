import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:myapp/services/models.dart';
import 'package:myapp/shared/bottom_nav.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TopicScreen(topic: topic),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/covers/${topic.img}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    const Text(
                      "2020-21-23",
                      style: TextStyle(color: Color(0xFFC5D0DB)),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ClipOval(
                      child: Material(
                        color: Color(0xFFECFBDF),
                        child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Icon(
                              FontAwesomeIcons.leaf,
                              color: Color(0xFF9ED593),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  const TopicScreen({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF84C879),
        title: Text(topic.title),
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.asset('assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Text(
          topic.title,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),

      ///Floating Navbar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt_rounded),
        onPressed: () {},
        backgroundColor: const Color(0xFF84C879),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
