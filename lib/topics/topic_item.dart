// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:myapp/services/models.dart';

class TopicItem extends StatelessWidget {
  final Scan scan;
  const TopicItem({Key? key, required this.scan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: scan.img,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TopicScreen(scan: scan),
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
                      child: Image.network(
                        scan.img,
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
                      scan.classification,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    Text(
                      scan.time,
                      style: const TextStyle(color: Color(0xFFC5D0DB)),
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
                  children: [
                    ClipOval(
                      child: Material(
                        color: generateColour(scan.classification),
                        child: SizedBox(
                            width: 60,
                            height: 60,
                            child: generateIcon(scan.classification)),
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

  generateIcon(String classification) {
    var icon = classification;
    switch (icon) {
      case 'Recycling':
        return Icon(
          FontAwesomeIcons.recycle,
          color: Color(0xFF4188D6),
        );
      case 'Garbage':
        return Icon(
          FontAwesomeIcons.trash,
          color: Color(0xFFFFC92B),
        );
      case 'Compost':
        return Icon(
          FontAwesomeIcons.leaf,
          color: Color(0xFF9ED593),
        );
      case 'Hazardous Waste':
        return Icon(
          FontAwesomeIcons.exclamation,
          color: Colors.red,
        );
      default:
        return Icon(
          FontAwesomeIcons.leaf,
          color: Color(0xFF9ED593),
        );
    }
  }

  generateColour(String classification) {
    var icon = classification;
    switch (icon) {
      case 'Recycling':
        return Color(0xFFEFF7FF);
      case 'Garbage':
        return Color(0xFFFFF8E3);
      case 'Compost':
        return Color(0xFFECFBDF);
      case 'Hazardous Waste':
        return Colors.red[100];
      default:
        return Color(0xFFECFBDF);
    }
  }
}

class TopicScreen extends StatelessWidget {
  final Scan scan;

  const TopicScreen({Key? key, required this.scan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF84C879),
        title: Text(scan.classification),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
      ),
      body: ListView(children: [
        Hero(
          tag: scan.img,
          child:
              Image.network(scan.img, width: MediaQuery.of(context).size.width),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: generateIcon(scan.classification),
              ),
              Text(
                scan.classification,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 50,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Before Disposing, Please Consider:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Text("1. Reusing the item"),
              Text("2. Donating the item."),
              Text("3. Selling the item."),
              Text("4. Reflecting on the waste source."),
            ],
          ),
        ),
      ]),
    );
  }

  generateIcon(String classification) {
    var icon = classification;
    switch (icon) {
      case 'Recycling':
        return Icon(
          FontAwesomeIcons.recycle,
          color: Color(0xFF4188D6),
        );
      case 'Garbage':
        return Icon(
          FontAwesomeIcons.trash,
          color: Color(0xFFFFC92B),
        );
      case 'Compost':
        return Icon(
          FontAwesomeIcons.leaf,
          color: Color(0xFF9ED593),
        );
      case 'Hazardous Waste':
        return Icon(
          FontAwesomeIcons.exclamation,
          color: Colors.red,
        );
      default:
        return Icon(
          FontAwesomeIcons.leaf,
          color: Color(0xFF9ED593),
        );
    }
  }
}
