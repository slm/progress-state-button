import 'package:flutter/material.dart';

class IconedButton {
  final String? text;
  final Icon? icon;
  final Color color;

  const IconedButton({
    this.text,
    this.icon,
    required this.color,
  });
}

Widget buildChildWithIcon(
    IconedButton iconedButton, double iconPadding, TextStyle textStyle) {
  return buildChildWithIC(
      iconedButton.text, iconedButton.icon, iconPadding, textStyle);
}

Widget buildChildWithIC(
    String? text, Icon? icon, double gap, TextStyle textStyle) {
  var children = <Widget>[];
  children.add(icon ?? Container());
  if (text != null) {
    children.add(Padding(padding: EdgeInsets.all(gap)));
    children.add(buildText(text, textStyle));
  }

  return Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: children,
  );
}

Widget buildText(String text, TextStyle style) {
  return Text(text, style: style);
}
