import 'package:flutter/material.dart';

class Article1 extends StatelessWidget {
  const Article1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Articles"),
          backgroundColor: const Color(0xFF84C879),
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Center(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                            child: Image.asset(
                              'assets/cover1.jpg',
                              width: 400,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          '''As the strike continues, it delays in the collection of garbage and organics, while recycling and yard waste will not be picked up during the labour disruption. The Region of Peel says residents affected by the strike should continue to put out their garbage on their scheduled day, but it may not be collected. This strike involved workers at Emterra Environmental, one of the region's waste collection contractors.

Author: Andy Chen''',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ]))));
  }
}
