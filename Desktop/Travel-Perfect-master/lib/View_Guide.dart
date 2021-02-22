import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Edit_Guide.dart';
import 'Model/Contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewGuide extends StatefulWidget {
  final String id;
  ViewGuide(this.id);
  @override
  _ViewGuideState createState() => _ViewGuideState(id);
}

class _ViewGuideState extends State<ViewGuide> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String id;
  _ViewGuideState(this.id);
  bool isLoading = true;

Contact _contact;
  getContact(id) async{
    _databaseReference.child(id).onValue.listen((event){
      setState(() {
        _contact = Contact.fromSnapshot(event.snapshot);
        isLoading = false;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    this.getContact(id);
  }
  
  callAction(String number) async{
    String url = 'tel:$number';
    if(await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Couldnot launch Url';
    }
  }

  smsAction(String number ) async {
    String url = 'sms:$number';
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Couldnot Launch';
    }
  }

  navigateToLastScreen(){
    Navigator.pop(context);
  }

  deleteContact(){
    showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title : Text('Delete?'),
        content: Text('Delete Contact'),
        actions:<Widget>[
          FlatButton(child: Text('Cancel'),
          onPressed: (){
            Navigator.of(context).pop();
          },
          ),
          FlatButton(
            onPressed: () async{
            Navigator.of(context).pop();
            await _databaseReference.child(id).remove();

          }
          , child: Text('Delete')
          )
        ]
      );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Your Travel Companion"),
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  // header text container
                  Center(
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 5.0
                        ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:  NetworkImage(_contact.photoUrl),
                        )
                        )),
                  ),
                  //name
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.perm_identity),
                            Container(
                              width: 10.0,
                            ),
                            Text(
                              "${_contact.firstName} ${_contact.lastName}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )),
                  ),
                  // phone
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone),
                            Container(
                              width: 10.0,
                            ),
                            Text(
                              _contact.phone,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )),
                  ),
                  // email
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.email),
                            Container(
                              width: 10.0,
                            ),
                            Text(
                              _contact.email,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )),
                  ),
                  // address
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.home),
                            Container(
                              width: 10.0,
                            ),
                            Text(
                              _contact.address,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )),
                  ),
                  // call and sms
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(Icons.phone),
                              color: Colors.red,
                              onPressed: () {
                                callAction(_contact.phone);
                              },
                            ),
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(Icons.message),
                              color: Colors.red,
                              onPressed: () {
                                smsAction(_contact.phone);
                              },
                            )
                          ],
                        )),
                  ),
                  // edit and delete
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // IconButton(
                            //   iconSize: 30.0,
                            //   icon: Icon(Icons.edit),
                            //   color: Colors.red,
                            //   onPressed: () {
                            //     // navigateToEditScreen(id);
                            //   },
                            // ),
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                deleteContact();
                              },
                            )
                          ],
                        )),
                  )
                ],
              ),
      ),
    );
  }
}