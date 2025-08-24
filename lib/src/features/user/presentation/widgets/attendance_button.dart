import 'package:flutter/material.dart';

class AttendanceButton extends StatelessWidget {
  const AttendanceButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.isLoading,
    required this.color,
  });

  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: isLoading ? color.withOpacity(0.7) : color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
