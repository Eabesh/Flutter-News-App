import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black12,
          title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text("Daily News",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
             Text("App", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.red),),
             Text("  Privacy Policy")
        ],
        ),),
      body: const WebView(
        initialUrl: 'https://sites.google.com/view/dailynewsappprivacypolicy',
        javascriptMode: JavascriptMode.unrestricted,
         )
    );
  }
}
