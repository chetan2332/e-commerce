import 'package:flutter/cupertino.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const LinkButton(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Text(text),
    );
  }
}
