import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mini_project/main_scrs/login.dart';
import '../components/Button.dart';
import '../constants.dart';
import 'home_scr.dart';

class Resgister1 extends StatefulWidget {
  const Resgister1({Key? key}) : super(key: key);

  @override
  State<Resgister1> createState() => _Resgister1State();
}

class _Resgister1State extends State<Resgister1> {
  String mail = "";
  String question = "";
  String password = "";
  String phone = "";
  String Uid = "";
  String qv = "";
  String drop = ' What city were you born in?';
  List<String> items = [
    ' What city were you born in?',
    ' What high school did you attend?',
    ' What is the country of your ultimate dream vacation?',
    ' Who was your childhood hero?',
    ' What is your preferred musical genre?'
  ];
  allowReg() async {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Registering",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.lightGreenAccent,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //User? currentAdmin;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password)
        .then((fAuth) {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Uid = currentUser.uid;
      }
      FirebaseFirestore.instance.collection("Users").doc(fAuth.user?.uid).set({
        "email": mail,
        "phone": phone,
        "password": password,
        "uid": Uid,
        "$question": qv
      });

      //print( FirebaseFirestore.instance.collection("Users").doc(fAuth.user?.uid));
      SnackBar snackBar = const SnackBar(
        content: Text(
          "Checking to register",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.lightGreenAccent,
        duration: Duration(seconds: 1),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LL();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).onError((error, stackTrace) {
      const snackBar = SnackBar(
        content: Text(
          "User registered already please login",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFC9703),
        title: const Text("REGISTER"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value) {
                        mail = value;
                      },
                      style: const TextStyle(fontSize: 17, color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        labelText: "EMAIL",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: "Enter valid mail",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      style: const TextStyle(fontSize: 17, color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: "Enter valid password",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    IntlPhoneField(
                      style: const TextStyle(fontSize: 17, color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        labelText: "PHONE",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: "Enter valid phone",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (value) {
                        phone = value.completeNumber;
                      },
                    ),
                    dropDown(),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      onChanged: (value) {
                        qv = value;
                      },
                      style: const TextStyle(fontSize: 17, color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )),
                        labelText: "ANSWER",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: "Enter valid answer",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Buttonm(
                        title: 'SIGNUP',
                        color: kPrimaryColor,
                        tapEvent: () {
                          allowReg();

                          //Navigator.push(context,MaterialPageRoute(builder: (context){return Registration();},),);
                        }),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget dropDown() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Color(0xFFFC9703), width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButton(
          isExpanded: true,
          alignment: AlignmentDirectional.center,
          icon: const Icon(Icons.arrow_downward),
          elevation: 8,
          style: const TextStyle(
            color: Colors.grey,
          ),
          underline: Container(),
          value: drop,
          items: items.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
          onChanged: (String? newV) {
            setState(() {
              drop = newV!;
              question = newV;
            });
          }),
    );
  }
}
