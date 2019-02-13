import 'package:flutter/material.dart';
import 'pages/settings.dart';
import 'model/database_helper.dart';
import 'model/device.dart';
import 'dart:async';
import 'package:home_security_gap_g4/pages/devicehome.dart';

Future main() async{
  var db= new DatabaseHelper();



  runApp(new MaterialApp(
    title: 'نرم افزار دزدگیر G4',
    theme: new ThemeData(
      primaryColor: Colors.red,
      primaryColorLight: Colors.redAccent.shade100,
      scaffoldBackgroundColor: Colors.amber.shade200,
      fontFamily: 'Sans4',
      primaryTextTheme: TextTheme(
       body1: TextStyle(
         fontSize: 14.0,
       )
      )

    ),
    home: new Login(db),
    debugShowCheckedModeBanner: false,
  ));
}

class Login extends StatefulWidget {
  var _db=new DatabaseHelper();

  Login(this._db);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginState(_db);
  }
}

class LoginState extends State<Login> {
  var _db=new DatabaseHelper();

  LoginState(this._db);


  @override
  Widget build(BuildContext context) {




    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl, child: new Scaffold(

      appBar:new AppBar(
        title: new Text('نرم افزار دزدگیر') ,
        //centerTitle: true,
        actions: <Widget>[
          //new FlatButton.icon(onPressed: null, icon: new Icon( Icons.settings) , label: null)
          new IconButton(icon: Icon(Icons.settings,color: Colors.yellow,), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>settings()));
          },tooltip: 'تنظیمات',)
        ],
      ),
      body:
        new Center(
          child: new Container(
            padding: EdgeInsets.fromLTRB(7.0, 25.0, 7.0, 7.0),

            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('لیست دزدگیرها'
                ,style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                new Expanded(child:
                new FutureBuilder<List<Device>>(
                  future: _db.getAllDevices(),
                  builder: (BuildContext context, AsyncSnapshot<List<Device>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = snapshot.data[index];
                          //return ListTile(
                          //  title: Text(item.title),
                            //leading: Text(item.id.toString()),

                         //);

                         /* return FlatButton.icon(onPressed: (){debugPrint(item.id.toString());},
                              icon: Icon(Icons.home ),
                              label: new Text(item.title),
                              padding: EdgeInsets.all(3.0),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                  
                                )
                              ),
                          );*/

                         return GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>devicehome(item.id)));
                           },
                           child: new Container(
                             padding: EdgeInsets.all(10.0),
                             alignment: Alignment.center,
                             margin: EdgeInsets.all(4.0),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                               border: Border.all(width: 3.0,color: Colors.red.shade900),
                               color: Colors.red.shade200,
                               //shape: BoxShape.circle,


                             ),
                             child: new Row(
                               children: <Widget>[
                                 new Container(
                                   child:
                                   new CircleAvatar(
                                     backgroundColor: Colors.red.shade900,
                                     child: new Icon(Icons.home,color: Colors.red.shade200,),
                                   ),
                                 ),
                                 new Container(
                                   alignment: Alignment.center,
                                   padding: EdgeInsets.only(right: 10.0),
                                   child: new Text(item.title,style:
                                     TextStyle(
                                       fontSize: 16.0,
                                       fontWeight: FontWeight.bold,
                                     )
                                     ,),
                                 )
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

