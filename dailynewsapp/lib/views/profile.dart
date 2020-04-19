import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class ProfileScreen extends StatelessWidget {
  final GoogleSignInAccount googleUser;
  final FirebaseUser firebaseUser;

  const ProfileScreen(
      {Key key, this.googleUser,this.firebaseUser})
      : assert(googleUser != null),
        assert(firebaseUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
      Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Offstage(
              offstage: firebaseUser.photoUrl == null,
              child: CircleAvatar(radius: 50,
                  backgroundImage: NetworkImage(firebaseUser.photoUrl)),
            ),
            SizedBox(height: 16.0),
            Text(firebaseUser.displayName, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            Text(firebaseUser.email),
            Text(firebaseUser.phoneNumber, style: theme.textTheme.subhead),
            SizedBox(height: 16.0),
            FlatButton(
              child: Text("CONTINUE TO APP", style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold,backgroundColor: Colors.yellow)),
              onPressed: () async {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
              },
            )
          ],
        ),
      ),
    );
  }
}