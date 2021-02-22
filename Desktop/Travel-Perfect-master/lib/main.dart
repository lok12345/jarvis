import 'package:flutter/material.dart';
import 'Homepage1.dart';
import 'signin.dart';
import 'signup.dart';
import 'mainDestinationPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Perfect',

      debugShowCheckedModeBanner: false,

      home:Homepage1(),

      routes: < String, WidgetBuilder > {
       "/SigninPage" : (BuildContext context ) => signin(),
       "/SignupPage" : (BuildContext context ) => SignupPage(),
       "/DestinationPage":(BuildContext context) => mainDestinationPage(),

      },
      
    );
  }
}
