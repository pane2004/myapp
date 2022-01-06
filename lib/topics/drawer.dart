import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:myapp/quiz/quiz.dart';
import 'package:myapp/services/models.dart';

class TopicDrawer extends StatelessWidget {
  const TopicDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: CircleAvatar(
              backgroundColor: Color(0xFF84C879),
              child: Text('JT'),
              radius: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 20),
            child: Text(
              "James Thompson",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF84C879),
                fontSize: 24,
              ),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1.5,
            height: 60,
          ),
          SideBar(
            title: "Statistics",
            icon: Icons.query_stats,
          ),
          SideBar(
            title: "Notifications",
            icon: Icons.notifications_active,
          ),
          SideBar(
            title: "History",
            icon: Icons.history,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1.5,
            height: 60,
          ),
          SideBar(
            title: "Settings",
            icon: Icons.settings,
          ),
          SideBar(
            title: "Privacy Policy",
            icon: Icons.privacy_tip,
          ),
          SideBar(
            title: "Help Centre",
            icon: Icons.help,
          ),
          SideBar(
            title: "Sign Out",
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  final String title;
  final IconData icon;

  const SideBar({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
          iconColor: const Color(0xFF84C879),
        ),
      ),
    );
  }
}

// class TopicDrawer extends StatelessWidget {
//   final List<Topic> topics;
//   const TopicDrawer({Key? key, required this.topics}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView.separated(
//           shrinkWrap: true,
//           itemCount: topics.length,
//           itemBuilder: (BuildContext context, int idx) {
//             Topic topic = topics[idx];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, left: 10),
//                   child: Text(
//                     topic.title,
//                     // textAlign: TextAlign.left,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ),
//                 QuizList(topic: topic)
//               ],
//             );
//           },
//           separatorBuilder: (BuildContext context, int idx) => const Divider()),
//     );
//   }
// }

// class QuizList extends StatelessWidget {
//   final Topic topic;
//   const QuizList({Key? key, required this.topic}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: topic.quizzes.map(
//         (quiz) {
//           return Card(
//             shape:
//                 const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//             elevation: 4,
//             margin: const EdgeInsets.all(4),
//             child: InkWell(
//               onTap: () {},
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(
//                     quiz.title,
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                   subtitle: Text(
//                     quiz.description,
//                     overflow: TextOverflow.fade,
//                     style: Theme.of(context).textTheme.subtitle2,
//                   ),
//                   leading: QuizBadge(topic: topic, quizId: quiz.id),
//                 ),
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     );
//   }
// }

// class QuizBadge extends StatelessWidget {
//   final String quizId;
//   final Topic topic;

//   const QuizBadge({Key? key, required this.quizId, required this.topic})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Report report = Provider.of<Report>(context);
//     List completed = report.topics[topic.id] ?? [];
//     if (completed.contains(quizId)) {
//       return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
//     } else {
//       return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);
//     }
//   }
// }
