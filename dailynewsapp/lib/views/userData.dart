import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Daily News",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            Text("App", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
              color: Colors.red,
            ),)
          ],
        ),
      ),
      backgroundColor: Colors.blue[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              Text(
                'Daily NewsApp',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Text(
                'Welcome You',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[400],
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Text("Keep visiting News App for latest News"),
              Card(
                  color: Colors.white,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.perm_identity,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      "${user?.displayName}",
                      style:
                      TextStyle(fontSize: 20.0),
                    ),
                  )),
              Card(
                color: Colors.white,
                margin:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    "${user?.phoneNumber}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    "${user?.email}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

