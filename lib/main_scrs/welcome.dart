import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/main_scrs/reg.dart';

import '../components/Button.dart';
import '../constants.dart';

class wee extends StatelessWidget {
  const wee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFC9703),
        title: const Text("SUCCESSFUL:)"),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
