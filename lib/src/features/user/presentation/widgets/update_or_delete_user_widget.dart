import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/user_custtom_button.dart';
import 'package:flutter/material.dart';

class UpdateOrDeleteUserWidget extends StatelessWidget {
  const UpdateOrDeleteUserWidget({
    super.key,
    this.onUpdate,
    this.onDelete,
    required this.isLoadign,
  });
  final bool isLoadign;
  final void Function()? onUpdate;
  final void Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UserCusttomButton(
          text: "Update User",
          color: kPrimaryColor,
          isLoading: isLoadign,
          onPressed: onUpdate ?? () {},
        ),
        const SizedBox(height: 12),

        UserCusttomButton(
          text: "Delete User",
          color: kOrange,
          isLoading: isLoadign,
          onPressed: onDelete ?? () {},
        ),
      ],
    );
  }
}
