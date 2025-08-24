import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/features/user/presentation/pages/attendance_page.dart';
import 'package:attendance_app/src/features/home/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;

  final List<Widget> pages = const [AttendancePage(), SettingsPage()];

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
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
