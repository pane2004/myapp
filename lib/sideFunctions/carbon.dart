// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/shared/error.dart';
import 'package:myapp/shared/loading.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CarbonScreen extends StatefulWidget {
  const CarbonScreen({Key? key}) : super(key: key);

  @override
  _CarbonScreenState createState() => _CarbonScreenState();
}

class _CarbonScreenState extends State<CarbonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Carbon Savings"),
          backgroundColor: const Color(0xFF84C879),
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
        body: fetchCarbon());
  }

  FutureBuilder<double> fetchCarbon() {
    return FutureBuilder<double>(
        future: FirestoreService().getCarbon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var carbon = snapshot.data!;
            var carbonString = carbon.toString();
            return Center(
                child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(25),
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 50, color: Colors.green),
                        GaugeRange(
                            startValue: 50,
                            endValue: 100,
                            color: Colors.orange),
                        GaugeRange(
                            startValue: 100, endValue: 150, color: Colors.red)
                      ], pointers: <GaugePointer>[
                        NeedlePointer(
                          value: carbon,
                          enableAnimation: true,
                        )
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('$carbonString LBs CO2',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: 0.5)
                      ])
                    ])),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Image.asset('assets/encouragewizard.png'),
                )
              ],
            ));
          } else {
            return const Text('No topics in Firestore. Check Database');
          }
        });
  }
}
