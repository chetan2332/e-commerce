import 'package:flutter/cupertino.dart';
import 'package:frontend/core/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const PrimaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: AppColors.accent,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
