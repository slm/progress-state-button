import 'package:flutter/material.dart';

class IconedButton {
  final String text;
  final Icon icon;
  final Color color;

  const IconedButton({
    this.text = "",
    this.icon,
    @required this.color,
  });
}

Widget buildChildWithIcon(
    IconedButton iconedButton, double iconPadding, TextStyle textStyle) {
  return buildChildWithIC(
      iconedButton.text, iconedButton.icon, iconPadding, textStyle);
}

Widget buildChildWithIC(
    String text, Icon icon, double gap, TextStyle textStyle) {
  return Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: <Widget>[
      icon,
      Padding(padding: EdgeInsets.all(gap)),
      buildText(text, textStyle)
    ],
  );
}

Widget buildText(String text, TextStyle style) {
  return Text(text, style: style);
}
