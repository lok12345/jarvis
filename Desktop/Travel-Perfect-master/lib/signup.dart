//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class SignupPage extends StatefulWidget {

  
  @override
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name ,_email , _password;

  checkAuthenticate() async {
    _auth.onAuthStateChanged.listen((user) async {
      if(user != null) {
        Navigator.pushReplacementNamed( context , "/");
      }
    });
  }
  navigateToSigninPage() {
    Navigator.pushReplacementNamed(context, "/SigninPage");
  }


  showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              onPressed:() { Navigator.of(context).pop(); },
              child: Text('Ok'))
          ],
        );
      }
      
      );
  }

  signup() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      
      try{
        FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password)).user;
      
      if(user !=null){
        UserUpdateInfo updateuser =UserUpdateInfo();
        updateuser.displayName = _name;
        user.updateProfile(updateuser);
      }
      }
      catch(e){
        showError(e.message);
      }
    }
  }

@override
void initState() {
  super.initState();
  this.checkAuthenticate();

}
  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: Container(
        child: ListView(
          children: <Widget>[
           
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
              child: Text('Registration ,',
              style: TextStyle(
                fontSize: 30.0,
              
              )
              )

            ),
            Container(
              child: Form(
                key:_formKey ,
                child: Column(
                  children: <Widget>[
                    Container(
                       padding: EdgeInsets.fromLTRB(20.0, 13.0, 10.0, 10.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return 'Enter name';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: ' Full Name',
                          border: OutlineInputBorder(
                            borderRadius : BorderRadius.circular(5.0),
                          )
                        ),
                        onSaved: (input) => _name = input,
                      )
                    ),
                    Container(
                       padding: EdgeInsets.fromLTRB(20.0, 13.0, 10.0, 10.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return 'Enter email';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius : BorderRadius.circular(5.0),
                          )
                        ),
                        onSaved: (input) => _email = input,
                      )
                    ),
                     Container(
                       padding: EdgeInsets.fromLTRB(20.0, 13.0, 10.0, 10.0),
                      child: TextFormField(
                        validator: (input){
                          if(input.length<6){
                            return 'Incorrect Password';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius : BorderRadius.circular(5.0),
                          )
                        ),
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      )
                    ),
                  ],
                ),
                )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50.0, 13.0, 50.0, 10.0),
              child: RaisedButton(
                color: Colors.blueAccent,
                onPressed: signup,
                child: Text('Register'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                )
            ),
            Center(
              child: GestureDetector(
                onTap: navigateToSigninPage,
                child: Text('Already have an account'),
              ),
            )

          ],
        )
      ),
      
    );
      
  
  }
}