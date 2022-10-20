import 'package:flutter/material.dart';

import '../constants.dart';
class navi extends StatelessWidget {
  const navi({
    Key? key,
    required this.title,
    required this.tapEvent
  }) : super(key: key);
  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(title,
          style: const TextStyle(
              color :Colors.black87,
              fontWeight: FontWeight.w300
          ),
        ),
      ),
    );
  }
}