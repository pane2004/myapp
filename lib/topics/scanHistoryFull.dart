import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/services/firestore.dart';

import 'package:myapp/services/models.dart';
import 'package:myapp/shared/bottom_nav.dart';
import 'package:myapp/shared/error.dart';
import 'package:myapp/shared/loading.dart';
import 'package:myapp/topics/topic_item.dart';

import 'drawer.dart';

class ScanHistoryFull extends StatelessWidget {
  const ScanHistoryFull({Key? key}) : super(key: key);

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
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: const Color(0xFF84C879),
                title: const Text('WasteWizard++'),
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              body: SingleChildScrollView(child: ScanHistory(scans: scans)),
            );
          } else {
            return const Text('No topics in Firestore. Check Database');
          }
        });
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        children: scans
            .map((scan) => TopicItem(
                  scan: scan,
                ))
            .toList(),
      ),
    ]);
  }
}
