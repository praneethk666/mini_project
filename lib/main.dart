import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/constants.dart';
import 'components/config.dart';
import 'main_scrs/home_scr.dart';
import 'main_scrs/welcome.dart';
final auth = FirebaseAuth.instance;
final configurations = Configurations();
Future<void> main() async{
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: configurations.apiKey,
          appId: configurations.appId,
          messagingSenderId: configurations.messagingSenderId,
          projectId: configurations.projectId)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key:key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADMIN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      ),
      home: FirebaseAuth.instance.currentUser == null?Home():wee(),
    );
  }
}

