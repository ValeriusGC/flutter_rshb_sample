import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final String text;

  const TabWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
    );
  }
}
