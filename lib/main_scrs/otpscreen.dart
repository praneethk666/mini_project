import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/main_scrs/welcome.dart';
class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  EmailAuth x = new EmailAuth(sessionName: 'PROJECT');
  String? phone = "";
  String? emailee ="";
  String verifyId = "";
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential)async{
    try{
      final authCredential= await auth.signInWithCredential(phoneAuthCredential);
      if(authCredential.user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const wee()));
      }
    }
    on FirebaseAuthException catch(e){
      print(e);
      verEmailOtp();
    }
  }
  void emailOtp() async{
    var res = await x.sendOtp(recipientMail: emailee.toString()
    );
    if(res){
      print("OTP sent");
    }
    else{
      print("Otp cannot be sent");
    }
  }
  void verEmailOtp() async{
    var res  = x.validateOtp(recipientMail: emailee.toString(), userOtp: otpController.text.toString());
    if(res){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const wee()));
    }
    else{
      print("Invalid OTP");
    }
  }


  Future getData() async {
    await FirebaseFirestore.instance.collection("Users").doc(
        FirebaseAuth.instance.currentUser!.uid).get().then((snaps) async {
      if (snaps.exists) {
        setState(() {
          phone = snaps.data()!["phone"];
          emailee = snaps.data()!["email"];
          print(emailee);
        });
      }
      //print(phone);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("OTP"),),
        body: Stack(
            children: [
              Center(
        child: Container(
          width: MediaQuery.of(context).size.width*.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(10.0),
                child: TextField(controller: otpController,

                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFC9703),
                          width: 2,
                        )
                    ),
                    labelText: "OTP",
                    hintText: "Enter valid otp",
                  ),
                ),),
              const SizedBox(height: 10,),
              TextButton(onPressed: () {
                fetchotp(phone);
              }, child: Text('Get OTP by phone number'),),
              const SizedBox(height: 10,),
              TextButton(onPressed: () {
                emailOtp();
              }
                , child: Text('Get OTP by mail'),),
              const SizedBox(height: 10,),
              TextButton(onPressed: () {
                verifyOtp();
              },
                  child: Text('submit'),),


            ],
          ),
        ),
      )
    ],
        )
    );
  }
Future<void> fetchotp(String? phone) async {
  await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e){
        if(e.code== 'invalid-phone-number'){
          print('invalid number');
        }
      },
      codeSent: (String verifyId,int? resendToken)async{
        this.verifyId = verifyId;
      },
      codeAutoRetrievalTimeout: (String verifyId){}
  );
}
Future<void> verifyOtp() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otpController.text.toString());
    signInWithPhoneAuthCredential(phoneAuthCredential);
}
}






