import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/components/getdelete.dart';
import 'package:mini_project/main_scrs/welcome.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'login.dart';
class QR extends StatefulWidget {
  @override
  State<QR> createState() => _QRState();
}
class _QRState extends State<QR> {
  String id = "";
  Future getData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snaps) async {
      if (snaps.exists) {
        setState(() {
          id = snaps.data()!["uid"];
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callAPi(id, context);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.width * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: id.toString(),
                  version: QrVersions.auto,
                  size: 250.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
  callAPi(String id, context) async {
    final serveApi = apiSeviceGet();
    serveApi.getApi(id, context).then((value) {
      if (value.name == id) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const wee();
            },
          ),
        );
      }
    });
    //print(id);
  }
}
