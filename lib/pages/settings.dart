import 'package:flutter/material.dart';
import 'package:home_security_gap_g4/pages/deviceadd.dart';
import 'package:home_security_gap_g4/model/database_helper.dart';
import 'package:home_security_gap_g4/model/device.dart';
import 'package:home_security_gap_g4/pages/devicesettings.dart';

class settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new settingsState();
  }
}

class settingsState extends State<settings> {
  var _db=new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl, child: new Scaffold(

        appBar:new AppBar(
          title: new Text('تنظیمات') ,
          //centerTitle: true,

        ),
        body:
        new Center(
            child: new Container(
              padding: EdgeInsets.fromLTRB(7.0, 25.0, 7.0, 7.0),

              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FlatButton.icon(

                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>add_device()));
                      },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.green.shade900,
                  style: BorderStyle.solid,
                  width: 4.0,
                )

              )
                      ,
                      icon: new Image.asset(
                        'assets/icons/bell.ico',
                        height: 45.0,
                      ),
                      color: Colors.green.shade700,

                      padding: EdgeInsets.all(10.0),
                      label: new Text('افزودن دستگاه'
                      ,style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  new Padding(padding: EdgeInsets.all(5.0)),

                  new Text('لیست دزدگیرها'
                    ,style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  new Expanded(

                    child:
                  new FutureBuilder<List<Device>>(
                    future: _db.getAllDevices(),
                    builder: (BuildContext context, AsyncSnapshot<List<Device>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = snapshot.data[index];
                            return

                              GestureDetector(
                              /*  onTap: (){
                                  debugPrint(item.id.toString());
                                },*/
                                child: new Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(width: 3.0,color: Colors.red.shade900),
                                      color: Colors.red.shade200,
                                      //shape: BoxShape.circle,


                                    ),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: <Widget>[
                                        new Container(
                                          child: new CircleAvatar(
                                            backgroundColor: Colors.red.shade900,
                                            child: new Icon(Icons.home,color: Colors.red.shade200,),
                                          ),
                                        ),

                                        new Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new Text(item.title,style:
                                          TextStyle(
                                           // fontSize: 16.0,

                                            fontWeight: FontWeight.w900,
                                          )
                                            ,),
                                        ),

                                        new GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>dev_settings(item.id)));

                                          },
                                          child: new Container(child:
                                            new Column(
                                                //mainAxisAlignment: MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                            new CircleAvatar(
                                            backgroundColor: Colors.green.shade900,
                                                child: new Icon(Icons.settings,color: Colors.red.shade200,))
                                                ]
                                           /* child: new CircleAvatar(
                                              backgroundColor: Colors.green.shade900,
                                              child: new Icon(Icons.settings,color: Colors.red.shade200,),
                                            ),*/
                                            ),
                                          ),
                                        ),

                                      ],
                                    )



                                  /*new Text(item.title,style: TextStyle(
                               fontSize: 22.0,
                               fontWeight: FontWeight.w700,


                             ),),*/
                                ),
                              );


                          },
                        );
                      } else {
                        // debugPrint(snapshot.data.length.toString());
                        return Center(child: CircularProgressIndicator());
                      }
                    },

                  ),
                  )
                ],
              ),
            )
        )



    )

    );
  }
}
