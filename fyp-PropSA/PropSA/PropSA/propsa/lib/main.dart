import 'package:flutter/material.dart';
import 'package:propsa/screen/home.dart';
import 'landingpage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PropSAApp());
}

class PropSAApp extends StatelessWidget {
  const PropSAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prop S&A',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snap){

        if(snap.hasData){
          return home();
        }
        return LandingPage();
      }),
    );
  }
}