import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive.dart';
import 'menuitems.dart';

class hoodie extends StatelessWidget {
  const hoodie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: <Widget>[
          Text(
            "SECURE",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
          ),
          //Image.asset('assets/images/1.jpg',width: 60,),
          const SizedBox(width: 3),
          Text(
            "SYSTEMS",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
          ),
          const Spacer(),
          if (!isMobile(context))
            Row(
              children: [
                navi(
                  title: 'HOME',
                  tapEvent: () {},
                ),
                //SizedBox(height: 10,),
                navi(
                  title: 'LOGIN',
                  tapEvent: () {},
                ),
                //SizedBox(height: 10,),
                navi(
                  title: 'SIGNUP',
                  tapEvent: () {},
                ),
              ],
            ),
          if (isMobile(context))
            IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu)),
        ],
      ),
    );
  }
}
