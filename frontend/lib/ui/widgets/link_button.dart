import 'package:flutter/cupertino.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  const LinkButton({
    super.key,
    this.color,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Text(text),
    );
  }
}
