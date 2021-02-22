// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'map.dart';

class mainDestinationPage extends StatelessWidget {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  List location = [
    "Annapurna Base Camp",
    "Mardi Himal Trek",
    "Tilico Trek",
    "Everest 3 Passes Trek"
  ];
  List locationImage = [
    "https://i.pinimg.com/564x/37/65/82/3765828e3833d7b8d9f354d10610bb22.jpg",
    "https://i.pinimg.com/564x/ca/a6/a3/caa6a3b565e0cfab0f00516d36e89893.jpg",
    "https://i.pinimg.com/564x/ae/92/08/ae920814155a27ca29883652aeca9123.jpg",
    "https://i.pinimg.com/564x/19/d2/ca/19d2ca383d24cc412528be5dac75ca15.jpg"
  ];

  List district = [
    "Kaski,Nepal",
    "Kaski,Nepal",
    "Manang,Nepal",
    "Solukhumbu,Nepal"
  ];

  List walkingDays = ["5-7 Days", "4-6 Days", "7-9 Days", "18-19 Days"];

  List bestSeason = [
    "Mar-May & Sep-Nov",
    "Mar-May & Sep-Nov",
    "Mar-May & Sep-Nov",
    "Mar-May & Sep-Nov"
  ];

  List elevation = ["4130m", "43000m", "4900m", "5500"];
  List<double> latitude = [28.5300, 28.4636, 28.6833, 28.0043];
  List<double> longitude = [83.8780, 83.9032, 83.8567, 86.8557];
  List finaldestination = [
    "Annapurna Base camp",
    "Mardi Base Camp",
    "Tilicho Lake",
    "Everest Base Camp"
  ];

  _message(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Searching Companion', style: GoogleFonts.lato()),
            content: Text(
              "We will notify shortly after finding your Companion",
              style: GoogleFonts.lato(),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok',
                  style: GoogleFonts.lato(),
                ),
              ),
            ],
          );
        });
  }

  Widget _getInnerTop(
      int index, String walkingDays, String bestSeason, String elevation) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.blue[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Trip Facts',
              style: GoogleFonts.lato(
                fontSize: 30.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
              child: Row(children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            Container(
              child: FaIcon(
                Icons.transfer_within_a_station,
              ),
            ),
            Container(
                child: Text(
              "Trip Duration :",
              style: GoogleFonts.lato(
                fontSize: 15,
              ),
            )),
            Container(
              child: Text(
                "${walkingDays}",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 15,
                ),
              ),
            ),
          ])),
          Expanded(
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  child: FaIcon(Icons.calendar_today),
                ),
                Container(
                    child: Text(
                  "Best Season :",
                  style: GoogleFonts.lato(
                    fontSize: 15,
                  ),
                )),
                Container(
                  child: Text(
                    "${bestSeason}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  child: FaIcon(Icons.trending_up),
                ),
                Container(
                    child: Text(
                  "Elevation :",
                  style: GoogleFonts.lato(
                    fontSize: 15,
                  ),
                )),
                Container(
                  child: Text(
                    "${elevation}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getInnerButtom(
      int index, double latitude, double longitude, String finaldestination) {
    return Builder(builder: (context) {
      return GestureDetector(
          onTap: () {
            SimpleFoldingCellState foldingCellState = context
                .ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
            foldingCellState?.toggleFold();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: SizedBox(
                          //height: 200.0,
                          width: 200.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusElevation: 20.0,
                            // onPressed: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => map(latitude,longitude,finaldestination),
                            //       ));
                            // },
                            child: Text(
                              'Area Map',
                              style: GoogleFonts.lato(fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: SizedBox(
                            //height: 200.0,
                            width: 200.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              // focusElevation: 20.0,
                              onPressed: () {
                                _message(context);
                              },

                              child: Text(
                                'Find a Comapanion',
                                style: GoogleFonts.lato(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Widget _getFront(int index, String location, String photos, String district) {
    return Builder(builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.blue[200],
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            SimpleFoldingCellState foldingCellState = context
                .ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
            foldingCellState?.toggleFold();
          },
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage("${photos}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '${location}',
                              style: GoogleFonts.lato(
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Row(children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                            child: FaIcon(
                              Icons.location_on,
                            ),
                          ),
                          Container(
                            child: Text(
                              "$district",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ])),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10)),
                              Container(
                                child: FaIcon(Icons.directions_walk),
                              ),
                              Container(
                                child: Text(
                                  "5-7 Days",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[200],
        child: ListView.builder(
            itemCount: location.length,
            itemBuilder: (context, index) {
              return SimpleFoldingCell(
                  frontWidget: _getFront(index, location[index],
                      locationImage[index], district[index]),
                  innerTopWidget: _getInnerTop(index, walkingDays[index],
                      bestSeason[index], elevation[index]),
                  innerBottomWidget: _getInnerButtom(index, latitude[index],
                      longitude[index], finaldestination[index]),
                  cellSize: Size(MediaQuery.of(context).size.width, 175),
                  padding: EdgeInsets.all(15),
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: 10,
                  onOpen: () => print('$index cell opened'),
                  onClose: () => print('$index cell closed'));
            }),
      ),
    );
  }
}
