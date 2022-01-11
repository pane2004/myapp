import 'package:flutter/material.dart';

class Article2 extends StatelessWidget {
  const Article2({Key? key}) : super(key: key);

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
                              'assets/cover2.jpg',
                              width: 400,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          '''Benefit of recycling; Recycling diverts waste from landfill: It stop material from being sent to landfill each year, that reduces our conserves land space, Recycling conserves resource：by recycling products made using natural resources, we reduce the load on our environment, Recycling waves energy: To use recycled printed paper and packaging as raw materials, it conserves both transportation and processing energy.

Author: Andy Chen''',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ]))));
  }
}
