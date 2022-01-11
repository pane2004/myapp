// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Help Centre"),
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
                Qa(question: '''Q: Where can I find more info about recycling?
''', answer: '''A: There are articles about recycling in our app.
'''),
                Qa(
                    question:
                        '''Q: How come I can't find a waste depot in my area?
''',
                    answer:
                        '''A: Currently WasteWizard++ only supports depot locations located in the Great Toronto Area. The core issue is that all data must be manually gathered for this specific data, and so we have not been able to implement it. Dynamic locations/maps will be implemented in the future through a crowdsourcing data model.
'''),
                Qa(
                    question: '''Q: How do I contact WasteWizard++?''',
                    answer:
                        '''A: If you have any questions you can contact us by sending an email to WasteWizard@gmail.com.
'''),
                Qa(
                    question:
                        '''Q: Where can I find more information about WasteWizard++?
''',
                    answer:
                        '''A: Our application is 90% open source. Additional information regarding the application, in addition to our source code can be found on our Github repository. 
'''),
                Qa(
                    question: '''Q: Why is recycling important?
''',
                    answer:
                        '''A: You can help our world by simply starting recycling, so why not? The complicated process of sorting your recycling is handled by the city, and now, the process of determining recyclable items is also handled by this application! Recycling will not only help reduce your carbon footprint, but it also helps reduce the need for harvesting raw materials, saves energy, reduces greenhouse gases, prevents pollution, and more.
'''),
                Qa(
                    question: '''Q: How do I use the app?
''',
                    answer:
                        '''A: All you need to do is click the center camera button on the bottom bar! The rest of the application is handled by our in-house Machine Learning engine. All image processing is done on the local machine. 
'''),
                Qa(
                    question: '''Q: Will the app steal my personal information?
''',
                    answer:
                        '''A: No, we will not share any of your information to a third party. All user information is encrypted. 
'''),
                Qa(
                    question:
                        '''Q: How do I know what garbage they are taking and when garbage trucks are coming?
''',
                    answer:
                        '''A: There is a calendar in our app that displays the disposal schedule for the Peel region. The core issue is that all data must be manually gathered for this specific data, and so we have not been able to implement it. Dynamic calendars will be implemented in the future through a crowdsourcing data model. 
'''),
                Center(
                  child: ElevatedButton(
                    child: Text("Source Code + Full Documentation"),
                    onPressed: () async {
                      const url = 'https://github.com/pane2004/myapp';

                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: true,
                          forceWebView: true,
                          enableJavaScript: true,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class Qa extends StatelessWidget {
  final String question;
  final String answer;

  const Qa({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(answer),
      ],
    );
  }
}
