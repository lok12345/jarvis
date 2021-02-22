// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelperfect/Add_Guide.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'Guide_Information.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Homepage1 extends StatefulWidget {
  @override
  _Homepage1State createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
//  _DestinationPage(){
//    Navigator.push(context,
//    MaterialPageRoute(builder: (context)=> Homepage()));
//  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isSigned = false;

  checkAuthentication() {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
    });
  }

  getuser() async {
    FirebaseUser firebaseuser = await _auth.currentUser();
    await firebaseuser?.reload();
    firebaseuser = await _auth.currentUser();

    if (firebaseuser != null) {
      setState(() {
        this.user = firebaseuser;
        this.isSigned = true;
      });
    }
    print(this.user);
  }

  signOut() async {
    _auth.signOut();
  }

//Function To Launch Hotel Booking URL
  launchHotelBooking() async {
    const url = 'https://www.oyorooms.com/np/';
    if (await canLaunch(url)) {
      print('URL being Launched');
      await launch(url);
    } else {
      throw 'Could not launch URL';
    }
  }

  launchAirlineBooking() async {
    const url = 'https://sastotickets.com/';
    if (await canLaunch(url)) {
      print('URL being Launched');
      await launch(
        url,
      );
    } else {
      throw 'Could not launch URL';
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Perfect'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text((user.displayName)),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(user.displayName.substring(0, 1)),
              ),
            ),
            ListTile(
              title: Text('Home'),
              trailing: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Destinations'),
              trailing: Icon(Icons.place),
              onTap: () => Navigator.of(context).pushNamed('\DestinationPage'),
            ),
            ListTile(
              title: Text('Guide Registration'),
              trailing: Icon(Icons.group),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddGuide()));
              },
            ),
            ListTile(
              title: Text('Hotel Booking'),
              trailing: Icon(Icons.hotel),
              // onTap: launchHotelBooking(),
            ),
            ListTile(
              title: Text("Airlines"),
              trailing: Icon(Icons.flight_takeoff),
              // onTap: launchAirlineBooking(),
            ),
            ListTile(
              title: Text('Videos'),
              trailing: Icon(Icons.video_label),
            ),
            ListTile(
              title: Text('Feedback'),
              trailing: Icon(Icons.feedback),
            ),
            ListTile(
              title: Text('Signout'),
              trailing: Icon(Icons.exit_to_app),
              onTap: signOut,
            )
          ],
        ),
      ),
      body: new Container(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  GestureDetector(
                      child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(8),
                          //  // child: IconButton(icon: Icons., onPressed: null),

                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.place,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'Destination',
                                textAlign: TextAlign.justify,
                              )
                            ],
                          )),
                      onTap: () {
                        Navigator.of(context).pushNamed('/DestinationPage');
                      }),
                  GestureDetector(
                      child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'Travel Companion',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GuideInformation()));
                      }),
                  GestureDetector(
                      child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.hotel,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'Hotel Booking',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                      onTap: () {
                        print('Launching URL');
                        launchHotelBooking();
                      }),
                  GestureDetector(
                      child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.flight_takeoff,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'Airlines',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                      onTap: () {
                        launchAirlineBooking();
                      }),
                  GestureDetector(
                      child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.video_label,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'Videos',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                      onTap: () {}),
                  GestureDetector(
                      child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.more_horiz,
                                size: 35.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'View More',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                      onTap: () {}),
                ],
              ),
            ),
            SliverFillRemaining(
              child: ListView(
                children: [
                  CarouselSlider(
                    items: [
                      Stack(children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage("images/bungy.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            print('Gesture Detector');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    title: Text(
                                      'Bungee Jump',
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Container(
                                      height: 120.0,
                                      width: 100.0,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(FontAwesomeIcons
                                                    .locationArrow),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Container(
                                                    child: Text('Kusma,Nepal')),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(FontAwesomeIcons
                                                      .calendar),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    '2021-02-24',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                      FontAwesomeIcons.phone),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    '9865008005',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                      FontAwesomeIcons.info),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    'Duration : 6 days',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Got it'))
                                    ],
                                  );
                                });
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Bungee Jump',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 0.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                Icon(Icons.location_city),
                                Text(
                                  'Kushma,Nepal',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                      Stack(children: [
                        GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "images/matthew-mcbrayer-kgkGRmi-EtI-unsplash.jpg"),
                                  fit: BoxFit.cover,
                                ), //
                              ),
                            ),
                            onTap: () {
                              print('Gesture Detector');
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      title: Text(
                                        'kayaking',
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Container(
                                        height: 120.0,
                                        width: 100.0,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(FontAwesomeIcons
                                                      .locationArrow),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Container(
                                                      child: Text(
                                                          'Trishuli River')),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(FontAwesomeIcons
                                                        .calendar),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                        child: AutoSizeText(
                                                      '2021-02-29',
                                                      maxLines: 5,
                                                      maxFontSize: 15,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                        FontAwesomeIcons.phone),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                        child: AutoSizeText(
                                                      '9865008005',
                                                      maxLines: 5,
                                                      maxFontSize: 15,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                        FontAwesomeIcons.info),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                        child: AutoSizeText(
                                                      'Duration : 6 days',
                                                      maxLines: 5,
                                                      maxFontSize: 15,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Got it'))
                                      ],
                                    );
                                  });
                            }),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Kayaking',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 0.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Trishuli River',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                      Stack(children: [
                        GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "images/brad-pearson-2MO_9uDDu30-unsplash.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              print('Gesture Detector');
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      title: Text(
                                        'Rafting',
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Container(
                                        height: 120.0,
                                        width: 100.0,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(FontAwesomeIcons
                                                      .locationArrow),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Container(
                                                      child: Text(
                                                          'Trishuli & Seti River')),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(FontAwesomeIcons
                                                        .calendar),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                        child: AutoSizeText(
                                                      '2021-03-24',
                                                      maxLines: 5,
                                                      maxFontSize: 15,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                        FontAwesomeIcons.phone),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                        child: AutoSizeText(
                                                      '9865008005',
                                                      maxLines: 5,
                                                      maxFontSize: 15,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                        FontAwesomeIcons.info),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                        child: AutoSizeText(
                                                      'Duration : 6 days',
                                                      maxLines: 5,
                                                      maxFontSize: 15,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Got it'))
                                      ],
                                    );
                                  });
                            }),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Rafting',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 0.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Upper Seti River',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                      Stack(children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    "images/taylor-murphy-Kq6lLQVB0zM-unsplash.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            print('Gesture Detector');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    title: Text(
                                      'Ice Climbing',
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Container(
                                      height: 120.0,
                                      width: 100.0,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(FontAwesomeIcons
                                                    .locationArrow),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Container(
                                                    child:
                                                        Text('Humde,Manang')),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(FontAwesomeIcons
                                                      .calendar),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    '2021-04-03',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                      FontAwesomeIcons.phone),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    '9865008005',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                      FontAwesomeIcons.info),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    'Duration : 6 days',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Got it'))
                                    ],
                                  );
                                });
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Ice Climbing',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 0.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  'Humde,Manang',
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                      Stack(children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    "images/tim-foster-qrIy8dBzCVU-unsplash.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            print('Gesture Detector');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    title: Text(
                                      'Mountain Biking',
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Container(
                                      height: 120.0,
                                      width: 100.0,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(FontAwesomeIcons
                                                    .locationArrow),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Container(
                                                    child: Text(
                                                        'Ride All Over Nepal')),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(FontAwesomeIcons
                                                      .calendar),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    '2021-04-25',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                      FontAwesomeIcons.phone),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    '9865008005',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                      FontAwesomeIcons.info),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                    'Duration : 6 days',
                                                    maxLines: 5,
                                                    maxFontSize: 15,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Got it'))
                                    ],
                                  );
                                });
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Mountain Biking',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 0.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                ),
                                Text(
                                  'All Over Nepal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                        height: 320.0,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {});
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
