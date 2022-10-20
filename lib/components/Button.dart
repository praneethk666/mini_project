import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
class Buttonm extends StatelessWidget {
  const Buttonm({
    Key? key,
    required this.title,
    required this.tapEvent,
    required this.color,
  }) : super(key: key);
  final String title;
  final GestureTapCallback tapEvent;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TextButton(
        onPressed: tapEvent,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20,vertical: 17))
        ),
        child: Text(title,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12,
        ),
        ),
      ),
    );
  }
}
