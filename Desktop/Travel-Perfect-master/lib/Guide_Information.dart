import 'package:flutter/material.dart';
import 'package:travelperfect/View_Guide.dart';
import 'Add_Guide.dart';
import 'Edit_Guide.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class GuideInformation extends StatefulWidget {
  @override
  _GuideInformationState createState() => _GuideInformationState();
}

class _GuideInformationState extends State<GuideInformation> {
  DatabaseReference _databaseReference =FirebaseDatabase.instance.reference();

  navigateToAddScreen(){
    Navigator.push(context , MaterialPageRoute(builder :(context){
      return AddGuide();
    }));
  }
  
  navigateToViewScreen(id){
    Navigator.push(context, MaterialPageRoute(builder:(context){
      return ViewGuide(id);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Companions'),
      ),

      body: Container(
        
                  child: FirebaseAnimatedList(
            query: _databaseReference, 
            itemBuilder: (BuildContext context , DataSnapshot snapshot,Animation<double>animation, int index ) {
              return GestureDetector(
                onTap : () {
                  navigateToViewScreen(snapshot.key);
                },
                
                                  child: Card(
                                    child: Container(
  
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:  NetworkImage(snapshot.value['photoUrl']),
                            )
                          ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            padding: EdgeInsets.all(20.0),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${snapshot.value['firstName']}" + "${snapshot.value['lastName']}"
                                ),
                                Text(
                                  "${snapshot.value['phone']}",
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            ),
        

      
        
      ),

      floatingActionButton:  FloatingActionButton(
          onPressed: navigateToAddScreen,
          child: Icon(Icons.add),

          ),

     
      
    );
  }
}