import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/presentation/pages/attendance_page.dart';
import 'package:attendance_app/src/presentation/pages/profile_page.dart';
import 'package:attendance_app/src/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final List<Widget> pages = const [
    AttendancePage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[pageIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: kLightBlue,
        buttonBackgroundColor: kPrimaryColor,
        index: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          Icon(Icons.check_circle, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
