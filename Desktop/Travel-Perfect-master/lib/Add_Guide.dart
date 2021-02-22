import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'Model/Contact.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'Homepage1.dart';

class AddGuide extends StatefulWidget {
  @override
  _AddGuideState createState() => _AddGuideState();
}

class _AddGuideState extends State<AddGuide> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _firstName='';
   String _lastName='';
  String _phone='';
  String  _email='';
  String  _address='';
  String _displayPhotoUrl='';

  saveInformation(BuildContext context) async {
    if(_firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _phone.isNotEmpty &&
        _address.isNotEmpty &&
        _email.isNotEmpty &&
        _displayPhotoUrl.isNotEmpty
     ){
       Contact contact = Contact(this._firstName,this._lastName,this._phone,this._address,this._email,this._displayPhotoUrl);

       await _databaseReference.push().set(contact.toJson());
       navigateToLastScreen(context);
  }
  else{
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Field Required'),
          content: Text('All Fileds are required'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text('Ok'),
               )
          ],
        );
      }
      );
  }
  }

  navigateToLastScreen(context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage1()));
  }
  
  Future pickImage () async{
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200.0,
      maxWidth: 200.0,
    );
    String fileName = basename(file.path);
    uploadImage(file, fileName);

  }
  uploadImage(File file, String fileName) async{
    StorageReference _storageReference = FirebaseStorage.instance.ref().child(fileName);

  _storageReference.putFile(file).onComplete.then((firebaseFile) async {
    var downloadUrl = await firebaseFile.ref.getDownloadURL();

    setState(() {
      _displayPhotoUrl = downloadUrl;
    });
  });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Information About Guide'),

      ),

      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top : 20.0),
                child: GestureDetector(
                  onTap:() {
                     this.pickImage();
                  },
                  child: Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 5.0
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_displayPhotoUrl),
                        )
                        
                      ),
                      child: Icon(Icons.camera_enhance,
                      size: 20.0,),
                    ),
                    ),
                ),
              
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _firstName = value;
                    });
                  },
                  decoration:InputDecoration(
                    labelText : 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                  decoration:InputDecoration(
                    labelText : 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration:InputDecoration(
                    labelText : 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                  decoration:InputDecoration(
                    labelText : 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _phone = value;
                    });
                  },
                  decoration:InputDecoration(
                    labelText : 'Phone no',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  )
                )
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.only(top:20.0),
                  onPressed:() 
                  {
                    saveInformation(context);
                  },
                  child: Text('Save Data'),

                  )
              )
            ],
          ),
          ),
        
      ),
      
      
    );

  }
}