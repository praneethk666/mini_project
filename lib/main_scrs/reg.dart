import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/Button.dart';
import '../constants.dart';
import 'findUser.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String mail = "";
  String password = "";
  String phone = "";
  allowLogin() async {
    SnackBar snackBar = const SnackBar(
      content: Text(
        ""
        "Checking login details",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: password)
        .then((fAuth) {
      currentAdmin = fAuth.user;
    }).catchError((onError) {
      final snackBar = SnackBar(
        content: Text(
          "Error occured$onError",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    if (currentAdmin != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentAdmin!.uid)
          .get()
          .then((snap) {
        if (snap.exists) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LL();
              },
            ),
          );
        } else {
          SnackBar snackBar = const SnackBar(
            content: Text(
              ""
              "No account found",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  const Color(0xFFFC9703),
        title: const Text("LOGIN"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/3.jpg',
                      width: 200,
                    ),
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
                        hintText: "ENTER VALID EMAIL",
                        hintStyle: TextStyle(color: Colors.grey),
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
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
                        hintText: "ENTER VALID PASSWORD",
                        hintStyle: TextStyle(color: Colors.grey),
                        icon: Icon(
                          Icons.password,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const findUser()));
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Buttonm(
                        title: 'LOGIN',
                        color: kPrimaryColor,
                        tapEvent: () {
                          allowLogin();
                        }),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
