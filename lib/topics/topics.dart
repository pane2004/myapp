// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/services/models.dart';
import 'package:myapp/shared/bottom_nav.dart';
import 'package:myapp/shared/loading.dart';
import 'package:myapp/shared/error.dart';
import 'package:myapp/topics/scanHistoryFull.dart';
import 'package:myapp/topics/topic_item.dart';
import 'package:myapp/topics/tool_item.dart';
import 'package:myapp/topics/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:myapp/topics/classifier.dart';
import 'package:myapp/topics/classifier_quant.dart';

final List<String> imgList = [
  "assets/cover1.jpg",
  "assets/cover2.jpg",
  "assets/cover3.jpg",
];

final List<String> toolList = [
  "My Carbon Savings",
  "Local Waste Depots",
  "Pickup Schedule",
];

final List<Widget> imageSliders = imgList
    .map((item) => Builder(builder: (context) {
          return Container(
            margin: const EdgeInsets.only(right: 30),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/$item');
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 800,
                      ),
                    ],
                  ),
                )),
          );
        }))
    .toList();

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  int _selectedIndex = 0;
  late Classifier _classifier;

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;

  bool isLoading = true;

  UploadTask? task;

  late String urlDownload;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      category = pred;
    });
  }

  Future uploadFile() async {
    if (_image == null) return;

    final fileName = basename(_image!.path);
    final destination = 'files/$fileName';

    task = FirestoreService.uploadFile(destination, _image!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    var link = await snapshot.ref.getDownloadURL();
    setState(() {
      urlDownload = link;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Scan>>(
      future: FirestoreService().getScans(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var scans = snapshot.data!;
          final screen = [
            MainHome(scans: scans),
            const ScanHistoryFull(),
          ];
          return Scaffold(
              backgroundColor: const Color(0xFFF9FCFF),
              drawer: nameFetch(),
              body: screen[_selectedIndex],

              ///Floating Navbar
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: isLoading
                  ? FloatingActionButton(
                      child: const Icon(Icons.camera_alt_rounded),
                      onPressed: () async {
                        setState(() {
                          isLoading = false;
                        });
                        await getImage();
                        await uploadFile();
                        FirestoreService().updateTotal();
                        await FirestoreService().updateScans(
                            urlDownload.toString(), category!.label.toString());
                        setState(() {
                          isLoading = true;
                        });
                        category == null
                            ? Text("Oof")
                            : Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TopicScreen(
                                    image: _image,
                                    output: category!.label,
                                  ),
                                ),
                              );
                      },
                      backgroundColor: const Color(0xFF84C879),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    ),
              bottomNavigationBar: BottomAppBar(
                shape: const AutomaticNotchedShape(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    StadiumBorder()),
                notchMargin: 5,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 70.0,
                    ),
                    IconBottomButton(
                        icon: Icons.home,
                        selected: _selectedIndex == 0,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        }),
                    const SizedBox(
                      width: 150.0,
                    ),
                    IconBottomButton(
                        icon: Icons.document_scanner,
                        selected: _selectedIndex == 1,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        }),
                    const SizedBox(
                      width: 70.0,
                    ),
                  ],
                ),
              ));
        } else {
          return const Text('No topics in Firestore. Check Database');
        }
      },
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
            return TopicDrawer(name: name);
          } else {
            return const Text('No topics in Firestore. Check Database');
          }
        });
  }
}

class TopicScreen extends StatelessWidget {
  final File? image;
  final String output;

  const TopicScreen({
    Key? key,
    required this.image,
    required this.output,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF84C879),
        title: Text(output),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
      ),
      body: ListView(children: [
        Hero(
          tag: 1,
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Image.file(
              image!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: generateIcon(output),
              ),
              Text(
                output,
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

class MainHome extends StatelessWidget {
  const MainHome({
    Key? key,
    required this.scans,
  }) : super(key: key);

  final List<Scan> scans;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const TopBar(),
        const Tools(),
        ScanHistory(scans: scans),
      ],
    );
  }
}

class ScanHistory extends StatelessWidget {
  const ScanHistory({
    Key? key,
    required this.scans,
  }) : super(key: key);

  final List<Scan> scans;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: buildHistory());
  }

  FutureBuilder<List<Scan>> buildHistory() {
    return FutureBuilder<List<Scan>>(
        future: FirestoreService().getScans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var name = snapshot.data!;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    children: name
                        .map((scan) => TopicItem(
                              scan: scan,
                            ))
                        .toList(),
                  ),
                ]);
          } else {
            return const Text('No topics in Firestore. Check Database');
          }
        });
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
