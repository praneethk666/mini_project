import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/main_scrs/qrauth.dart';
import 'package:mini_project/main_scrs/reg.dart';
import 'package:mini_project/main_scrs/reg1.dart';
import '../components/Button.dart';
import '../constants.dart';
import 'otpscreen.dart';
class LL extends StatefulWidget {
  const LL({Key? key}) : super(key: key);

  @override
  State<LL> createState() => _LLState();
}

class _LLState extends State<LL> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  const Color(0xFFFC9703),
        title: const Text("AUTHENTICATION"),
      ),
        backgroundColor: Colors.white,
        body: Stack(
        children: [
        Center(
        child: Container(
        width: MediaQuery.of(context).size.width*.5,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
      Image.asset('assets/images/6.jpg',width: 275,),
      Buttonm(title:'OTP Authentication',color: kPrimaryColor,tapEvent:(){
        Navigator.push(context,MaterialPageRoute(builder: (context){return const OTP();},),);
      }),
      const SizedBox(height: 13,),
      Buttonm(title:'QR Authentication',color: kScondaryColor,tapEvent:(){
        Navigator.push(context,MaterialPageRoute(builder: (context){return QR();},),);
      }),
      const SizedBox(height: 13,),
      Buttonm(title: "LOGOUT", tapEvent: (){
        FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Registration();
            },
          ),
        );
      }, color: kPrimaryColor)
    ]
    ),
    ),
    ),
    ],
    ),
    );
  }
}
