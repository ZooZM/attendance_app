import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/core/utils/styles.dart';
import 'package:attendance_app/src/presentation/widgets/custtom_button.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Current Status: Not Checked In",
                      style: Styles.subtitle18Bold,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Last action: -",
                      style: Styles.subtitle16Bold.copyWith(color: kGray),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            CusttomButton(text: "Check In", isLoading: false),
            const SizedBox(height: 12),

            CusttomButton(text: "Check Out", isLoading: false),
          ],
        ),
      ),
    );
  }
}
