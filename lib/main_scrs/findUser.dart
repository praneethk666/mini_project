import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class findUser extends StatefulWidget {
  const findUser({Key? key}) : super(key: key);

  @override
  State<findUser> createState() => _findUserState();
}

class _findUserState extends State<findUser> {
  var mController = TextEditingController();
  Map? map;
  String question = "";
  String answer = "";
  String qv = "";
  String drop = ' What city were you born in?';
  List<String> items = [
    ' What city were you born in?',
    ' What high school did you attend?',
    ' What is the country of your ultimate dream vacation?',
    ' Who was your childhood hero?',
    ' What is your preferred musical genre?'
  ];
  findUser() async {
    if (mController.text.isNotEmpty) {
      SnackBar snackBar = const SnackBar(
        content: Text(
          "Checking",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.lightGreenAccent,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .where("email", isEqualTo: mController.text)
            .get()
            .then((value) {
          for (var x in value.docs) {
            setState(() {
              map = x.data();
            });
          }
        });
      } on FirebaseException catch (e) {
        print(e);
      }
    }
    if (map?["$question"] == qv) {
      User? currentAdmin;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mController.text, password: map?["password"])
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:  const Color(0xFFFC9703),
          title: const Text("FORGOT PASSWORD"),
        ),
        body: Stack(children: [
          Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height* .5,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black),
                          controller: mController,
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
                            labelText: "email",
                            labelStyle:TextStyle(color: Colors.grey),
                            hintText: "Enter valid mail",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        dropDown(),
                        const SizedBox(height: 20),
                        TextField(
                          onChanged: (value) {
                            qv = value;
                          },
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black),
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
                            labelStyle:TextStyle(color: Colors.grey),
                            hintText: "VALID ANSWER",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            findUser();
                          },
                          child: const Text('submit'),
                        ),
                      ])))
        ]));
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
