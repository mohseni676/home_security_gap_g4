import 'package:flutter/material.dart';
import 'dart:async';
import 'package:home_security_gap_g4/model/device.dart';
import 'package:home_security_gap_g4/model/database_helper.dart';
import 'package:home_security_gap_g4/model/sms.dart';

class devicehome extends StatefulWidget {
  int _deviceId;

  devicehome(this._deviceId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new devicehomeState(_deviceId);
  }
}

class devicehomeState extends State<devicehome> {
  int _deviceId;
  DatabaseHelper _db = new DatabaseHelper();
  SMS _sms = new SMS();

  devicehomeState(this._deviceId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new FutureBuilder<Device>(
            future: _db.getDevice(_deviceId),
            builder: (BuildContext context, AsyncSnapshot<Device> snapshot) {
              if (snapshot.hasData) {
                String _passcode = snapshot.data.password;
                String _simnumber = snapshot.data.simnumber;
                return new Scaffold(
                    appBar: new AppBar(
                      title: new Text(snapshot.data.title),
                    ),
                    body: new Container(
                        padding: EdgeInsets.all(15.0),
                        child: new Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text('شماره سیم دستگاه'),
                              new Text(
                                snapshot.data.simnumber,
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3.0,
                                ),
                              ),
                              new Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0)),
                              new Card(
                                child: new Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            'عملیات های اصلی',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.all(3.0)),
                                        new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new GestureDetector(
                                              onLongPress: () {
                                                List<String> _contacts = [];
                                                _contacts.add(
                                                    snapshot.data.simnumber);

                                                _sms.SendSms(
                                                    _contacts, '$_passcode*1#');
                                              },
                                              child: new Container(
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      minRadius: 30.0,
                                                      child: new Icon(
                                                          Icons.lock,
                                                          color: Colors.white,
                                                          size: 36.0),
                                                    ),
                                                    new Text('تمام فعال'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            new GestureDetector(
                                              onLongPress: () {
                                                List<String> _contacts = [];
                                                _contacts.add(
                                                    snapshot.data.simnumber);
                                                _sms.SendSms(
                                                    _contacts, '$_passcode*2#');
                                              },
                                              child: new Container(
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      minRadius: 30.0,
                                                      backgroundColor:
                                                          Colors.orangeAccent,
                                                      child: new Icon(
                                                          Icons.lock,
                                                          color: Colors.white,
                                                          size: 36.0),
                                                    ),
                                                    new Text('نیمه فعال'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            new GestureDetector(
                                              onLongPress: () {
                                                List<String> _contacts = [];
                                                _contacts.add(
                                                    snapshot.data.simnumber);
                                                _sms.SendSms(
                                                    _contacts, '$_passcode*3#');
                                              },
                                              child: new Container(
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      minRadius: 30.0,
                                                      backgroundColor:
                                                          Colors.red,
                                                      child: new Icon(
                                                        Icons.lock_open,
                                                        color: Colors.white,
                                                        size: 36.0,
                                                      ),
                                                    ),
                                                    new Text('غیر فعال'),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                color: Colors.yellow[50],
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                    color: Colors.yellow[900],
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: EdgeInsets.all(5.0),
                                elevation: 5.0,
                              ),
                              new Card(
                                child: new Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            'عملیات های اضطراری',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.all(3.0)),
                                        new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new GestureDetector(
                                              onLongPress: () {
                                                List<String> _contacts = [];
                                                _contacts.add(
                                                    snapshot.data.simnumber);
                                                _sms.SendSms(
                                                    _contacts, '$_passcode*4#');
                                              },
                                              child: new Container(
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      minRadius: 30.0,
                                                      child: new Icon(
                                                          Icons.phone_missed,
                                                          color: Colors.white,
                                                          size: 36.0),
                                                    ),
                                                    new Text('توقف تماس'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            new GestureDetector(
                                              onLongPress: () {
                                                List<String> _contacts = [];
                                                _contacts.add(
                                                    snapshot.data.simnumber);
                                                _sms.SendSms(_contacts,
                                                    '$_passcode*70#');
                                              },
                                              child: new Container(
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      minRadius: 30.0,
                                                      backgroundColor:
                                                          Colors.blue,
                                                      child: new Icon(
                                                          Icons.error,
                                                          color: Colors.white,
                                                          size: 36.0),
                                                    ),
                                                    new Text('وضعیت دستگاه'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            new GestureDetector(
                                              onLongPress: () {
                                                List<String> _contacts = [];
                                                _contacts.add(
                                                    snapshot.data.simnumber);
                                                _sms.SendSms(_contacts,
                                                    '$_passcode*88#');
                                              },
                                              child: new Container(
                                                child: new Column(
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      minRadius: 30.0,
                                                      backgroundColor: Colors
                                                          .deepOrange[200],
                                                      child: new Icon(
                                                        Icons.sim_card_alert,
                                                        color: Colors.white,
                                                        size: 36.0,
                                                      ),
                                                    ),
                                                    new Text('اعتبار سیم'),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                color: Colors.yellow[50],
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                    color: Colors.yellow[900],
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: EdgeInsets.all(5.0),
                                elevation: 5.0,
                              ),
                              new GestureDetector(
                                onLongPress: () {
                                  debugPrint('GateWays');
                                },
                                child: new Container(
                                  width: 150.0,
                                  alignment: Alignment.center,

                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(
                                        style: BorderStyle.solid,
                                        width: 2.0,
                                        color: Colors.black26,
                                      )),
                                  //color: Colors.blueGrey,
                                  child: new Text('عملیات در گاه ها'),
                                ),
                              ),
                              new Text(
                                'لطفا چند ثانیه دست خود را بر روی دکمه ها نگهدارید',
                                textAlign: TextAlign.center,
                                textScaleFactor: 0.8,
                              ),
                            ],
                          ),
                        )));
              }
            }));
  }
}
