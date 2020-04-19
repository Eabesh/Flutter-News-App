import 'package:dailynewsapp/routes/auth.dart';
import 'package:dailynewsapp/views/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Daily News App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: _getLandingPage(),
    );
  }
}


Widget _getLandingPage() {
  return FutureBuilder<FirebaseUser>(
    future: FirebaseAuth.instance.currentUser(),
    builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
      if (snapshot.hasData) {
        return SplashScreen();
      } else {
        return AuthScreen();
      }
    }
  );
}
