import 'package:flutter/material.dart';
import 'package:mini_project/main_scrs/reg.dart';
import 'package:mini_project/main_scrs/reg1.dart';
import '../components/Button.dart';
import '../constants.dart';
import '../responsive.dart';
class jumper extends StatelessWidget {
  const jumper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding:  EdgeInsets.only(right: !isMobile(context) ? 40:0),
                child: Column(
                  mainAxisAlignment: !isMobile(context)?MainAxisAlignment.start:MainAxisAlignment.center,
                  crossAxisAlignment: !isMobile(context)?CrossAxisAlignment.start:CrossAxisAlignment.center,
                  children: <Widget>[
                    if(isMobile(context))
                      Image.asset(
                        'assets/images/main.png',
                        height: size.height*0.3,),
                    RichText(text:  TextSpan(
                        children: [
                          TextSpan(
                              text:'HEY',
                              style: TextStyle(
                                  fontSize: isDesktop(context)?64:32,
                                  fontWeight: FontWeight.normal,
                                color: Colors.brown[800],
                              )
                          ),

                          TextSpan(
                              text: 'USER',
                              style: TextStyle(
                                fontSize: isDesktop(context)?64:32,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown[800],
                              )
                          )
                        ]
                    )),
                    const SizedBox(height: 10,),
                    const SizedBox(height: 10,),
                    Wrap(
                      runSpacing: 10,
                      children: <Widget>[
                        Buttonm(title:' LOGIN ',color: Colors.lightGreen,tapEvent:(){
                          Navigator.push(context,MaterialPageRoute(builder: (context){return const Registration();},),);
                        }),
                        const SizedBox(width: 5,),
                        Buttonm(title:'SIGNUP',color: Colors.lightGreen,tapEvent:(){
                          Navigator.push(context,MaterialPageRoute(builder: (context){return const Resgister1();},),);
                        }),
                      ],
                    )
                  ],
                )
            ),
          ),
          if(isDesktop(context)||isTab(context))
            Expanded(
                child: Image.asset(
                  'assets/images/main.png',
                  height: size.height*0.7,)),

        ],
      ),
    );
  }
}

