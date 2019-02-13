import 'package:flutter/material.dart';
import 'package:home_security_gap_g4/model/device.dart';
import 'package:home_security_gap_g4/model/database_helper.dart';

class add_device extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new add_deviceState();
  }

}

class add_deviceState extends State<add_device> {
  DatabaseHelper _db=new DatabaseHelper();
  TextEditingController _deviceName=new TextEditingController();
  TextEditingController _deviceSimNumber=new TextEditingController();
  TextEditingController _devicePassword= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl,

        child:
        new Scaffold(
          appBar: new AppBar(
            title: new Text( 'افزودن دستگاه'),

          ),
          body: new Center(


          child:
              new Container(
                padding: EdgeInsets.all(25.0),
                child: new Column(
                  children: <Widget>[
                new Text('مشخصات دستگاه',
                  style: TextStyle(
                    fontSize: 24.0,

                  ),
                ),
                    new Expanded(child:
                    new ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: <Widget>[

                        new Padding(padding: EdgeInsets.all(5.0)),
                        new TextField(

                         // keyboardType: TextInputType.phone,
                          controller: _deviceName,
                          textAlign: TextAlign.center,
                          maxLength: 15,

                          decoration: InputDecoration(

                              border: OutlineInputBorder(
                                //gapPadding: 1.0,
                                  borderSide: BorderSide(
                                      color: Colors.black54,
                                      style: BorderStyle.solid,
                                      width: 2.0
                                  )
                                  ,borderRadius: BorderRadius.circular(15.0)

                              ),
                              hintText: 'نام دستگاه',
                              prefixIcon: Icon(Icons.perm_identity)
                          ),
                        ),
                        new Padding(padding: EdgeInsets.all(2.0)),
                        new TextField(
                          textAlign: TextAlign.center,
                          maxLength: 11,

                          controller: _deviceSimNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(

                              border: OutlineInputBorder(
                                //gapPadding: 1.0,
                                  borderSide: BorderSide(
                                      color: Colors.black54,
                                      style: BorderStyle.solid,
                                      width: 2.0
                                  )
                                  ,borderRadius: BorderRadius.circular(15.0)

                              ),
                              hintText: 'شماره سیم کارت دستگاه',
                              prefixIcon: Icon(Icons.sim_card)
                              ,
                          ),
                        ),
                        new Padding(padding: EdgeInsets.all(2.0)),
                        new TextField(
                          controller: _devicePassword,
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                              border: OutlineInputBorder(
                                //gapPadding: 1.0,
                                  borderSide: BorderSide(
                                      color: Colors.black54,
                                      style: BorderStyle.solid,
                                      width: 2.0
                                  )
                                  ,borderRadius: BorderRadius.circular(15.0)

                              ),
                              hintText: 'رمز دستگاه',
                              prefixIcon: Icon(Icons.lock)
                          ),
                        )
                      ],
                    ),
                    ),
                new FloatingActionButton(onPressed: (){
                  try {
                    _db.saveDevice(new Device(
                        _deviceName.text, _deviceSimNumber.text,
                        _devicePassword.text));
                    //_db.close();
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('ذخیره شد.')));
                    debugPrint('Saved');
                  }
                  catch (e){
                   // Scaffold.of(context).showSnackBar(SnackBar(content: Text('ذخیره نشد.')));
                    debugPrint('Not Saved: $e');
                  }

                },
                  child: new Icon(Icons.save),
                  backgroundColor: Colors.red ,

                )

                  ],
                )

              )
          ),
        )
    );
  }
}