import 'package:flutter/material.dart';

import 'menuitems.dart';
class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color:Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              navi(title: 'HOME',tapEvent: (){},),
              SizedBox(height: 10,),
              navi(title: 'LOGIN',tapEvent: (){},),
              SizedBox(height: 10,),
              navi(title: 'SIGNUP',tapEvent: (){},),
            ],
          ),
        ),
      ),
    );
  }
}
