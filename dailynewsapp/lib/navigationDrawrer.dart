
import 'package:dailynewsapp/routes/auth.dart';
import 'package:dailynewsapp/views/home.dart';
import 'package:dailynewsapp/views/privacyPolicy.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dailynewsapp/views/category_News.dart';
import 'package:google_sign_in/google_sign_in.dart';


class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: menuList(context),
    );
  }
}

Widget menuList(context) {
  return Container(
    color: Colors.black87,
    child: ListView(
      children: <Widget>[
        DrawerHeader(
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Daily NewsApp",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent
            )),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          trailing: Icon(Icons.trending_up, color: Colors.white),
          title: Text("Top Headlines",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),

        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryNews(
                  category: "business"
              )),
            );
          },
          trailing: Icon(Icons.business, color: Colors.white),
          title: Text("Business",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryNews(
                  category: "entertainment"
              )),
            );
          },
          trailing: Icon(Icons.live_tv, color: Colors.white),
          title: Text("Entertainment",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryNews(
                  category: "health"
              )),
            );
          },
          trailing: Icon(Icons.local_hospital, color: Colors.white),
          title: Text("Health",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryNews(
                  category: "science"
              )),
            );
          },
          trailing: Icon(Icons.all_inclusive, color: Colors.white),
          title:
          Text("Science", style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryNews(
                  category: "sports"
              )),
            );
          },
          trailing: Icon(Icons.pool, color: Colors.white),
          title: Text("Sports",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryNews(
                  category: "technology"
              )),
            );
          },
          trailing: Icon(Icons.devices, color: Colors.white),
          title: Text("Technology",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicy(
              )),
            );
          },
          trailing: Icon(Icons.next_week, color: Colors.white),
          title: Text("Privacy Policy",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ListTile(
          onTap: () async {
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => AuthScreen()),
                (route)=>false,
            );
          },
          trailing: Icon(Icons.power_settings_new, color: Colors.red),
          title: Text("SIGN OUT",
              style: TextStyle(color: Colors.red, fontSize: 30)),
        ),
      ],
    ),
  );
}