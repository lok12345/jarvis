import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
  
}

 class _signinState extends State<signin> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState>  _formKey= GlobalKey<FormState>();
   String _email , _password;
  //to check wheather or not user is signed in
  
  checkAuthenication() async {
    _auth.onAuthStateChanged.listen((user) async {
      if(user != null) {
        Navigator.pushReplacementNamed(context, "/");

      }
    });
  }
  
  //Funnction to transfer to signup ui
  navigateToSigup() {
    Navigator.pushReplacementNamed(context, "/SignupPage");
  }

  @override
    void initState() {

      super.initState();
      this.checkAuthenication();

    }


  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: _email, password: _password)).user;
        
      }
      catch (e) {
        showError(e.message);
      }
    }

    
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
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 0.0),
              child: Image(
                image: AssetImage("images/TravelPerfect.png"),
                height: 100.0,
                width: 100.0,
                alignment: Alignment.topLeft,
                ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
              child: Text('Welcome ,',
              style: TextStyle(
                fontSize: 30.0,
              
              )
              )

            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
              child: Text('Signin to continue ',
              style: TextStyle(
                fontSize: 20.0,
              
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
                onPressed: signIn,
                child: Text('Signin'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                )
            ),
            Center(
              child: GestureDetector(
                onTap: navigateToSigup,
                child: Text('Create an Account ?'),
              ),
            )

          ],
        )
      ),
      
    );
  }
}