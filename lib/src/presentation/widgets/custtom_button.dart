import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/core/widgets/custom_circular_progress.dart';
import 'package:flutter/material.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.isLoading,
  });

  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: isLoading
            ? kGray
            : const Color(0xff3A4D6F), // Sets button background color
        foregroundColor: Colors.white, // Ensures text color is set explicitly
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: isLoading
          ? const CustomCircularprogress(size: 15)
          : Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
