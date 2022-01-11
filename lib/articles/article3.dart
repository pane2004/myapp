import 'package:flutter/material.dart';

class Article3 extends StatelessWidget {
  const Article3({Key? key}) : super(key: key);

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
                              'assets/cover3.jpg',
                              width: 400,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          '''The benefit of compost, it can save resources, there are valuable resources out of the landfill that it could save and reduce landfill wastes. It also could reduce GreenHouse gases. It can help to save the environment. The benefit of garbage, is that it could save time to deal with garbage, and it has less cost than other methods. It has less trash than others. 

Author: Andy Chen''',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ]))));
  }
}
