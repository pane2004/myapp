import 'package:myapp/about/about.dart';
import 'package:myapp/articles/article1.dart';
import 'package:myapp/articles/article2.dart';
import 'package:myapp/articles/article3.dart';
import 'package:myapp/drawerScreens/help.dart';
import 'package:myapp/drawerScreens/notifications.dart';
import 'package:myapp/drawerScreens/privacy.dart';
import 'package:myapp/drawerScreens/statistics.dart';
import 'package:myapp/profile/profile.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/sideFunctions/calendar.dart';
import 'package:myapp/sideFunctions/carbon.dart';
import 'package:myapp/sideFunctions/depot_map.dart';
import 'package:myapp/topics/topics.dart';
import 'package:myapp/topics/scanHistoryFull.dart';
import 'package:myapp/home/home.dart';
import 'drawerScreens/settings.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/scanHistory': (context) => const ScanHistoryFull(),
  '/Local Waste Depots': (context) => const MapScreen(),
  '/Pickup Schedule': (context) => const Calendar(),
  '/settings': (context) => const SettingsScreen(),
  '/statistics': (context) => const StatScreen(),
  '/noti': (context) => const NotificationScreen(),
  '/privacy': (context) => const PrivacyScreen(),
  '/help': (context) => const HelpScreen(),
  '/assets/cover1.jpg': (context) => const Article1(),
  '/assets/cover2.jpg': (context) => const Article2(),
  '/assets/cover3.jpg': (context) => const Article3(),
  '/My Carbon Savings': (context) => const CarbonScreen(),
};
