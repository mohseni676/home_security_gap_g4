import 'package:flutter/material.dart';
import 'package:home_security_gap_g4/model/sms.dart';
import 'package:home_security_gap_g4/model/database_helper.dart';
import 'package:home_security_gap_g4/model/device.dart';
import 'package:async/async.dart';

class dev_settings extends StatefulWidget{
  int _deviceId;

  dev_settings(this._deviceId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new dev_settingsSt(_deviceId);
  }

}

class dev_settingsSt extends State<dev_settings> {
  int _deviceId;

  dev_settingsSt(this._deviceId);
  DatabaseHelper _db=new DatabaseHelper();
  SMS _sms = new SMS();

  void _showDialog(int id) {
    // flutter defined function
    showDialog(

      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              width: 2.0,
              style: BorderStyle.solid,

            ),

          ),

          title: new Text("حذف دستگاه"),
          content: new Text("آیا از حذف دستگاه اطمینان دارید؟"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("بلی"),
              onPressed: () {
                //Navigator.of(context).pop();
                _db.deleteDevice(id);
                Navigator.of(context).pop();
              },

            ),
            new FlatButton(
              child: new Text("خیر"),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),

          ],
        ),
        );
      },
    );
  }

  void _showChangePassDialog(Device OldDevice){
    TextEditingController _oldPass = new TextEditingController();
    TextEditingController _newPass= new TextEditingController();
    //TextEditingController _newPass = new TextEditingController();

    final _key=GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context){
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(

            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
            width: 2.0,
            style: BorderStyle.solid,
            ),
          ),


          title: new Text('تغییر رمز:'),
            content: new Form(
              key: _key,
              child:
              new ListView(
                children: <Widget>[
                  new TextFormField(
                    validator: (value){
                      if (value.isEmpty){
                        return 'لطفا رمز قدیم را وارد کنید';
                      }
                    },
                    controller: _oldPass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_open),
                      hintText: 'رمز قدیمی',
                    ),
                  ),
                  new TextFormField(
                    validator: (value){
                      if (value.isEmpty){
                        return 'لطفا رمز قدیم را وارد کنید';
                      }
                    },
                    controller: _newPass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'رمز جدید',
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("ثبت"),
                onPressed: () {
                  //Navigator.of(context).pop();
                  String _oldPassword=_oldPass.text;
                  String _newPassword=_newPass.text;
                  if (_oldPassword==OldDevice.password){
                    List<String> _contacts;
                    _contacts.add(OldDevice.simnumber);
                    _sms.SendSms(_contacts, '${OldDevice.password}*35*$_newPass*$_newPass#');
                    Device _newDevice=Device.fromMap({
                      'id':OldDevice.id,
                      'title':OldDevice.title,
                      'password':_newPassword,
                      'simnumber':OldDevice.simnumber,
                    });
                    _db.updateDevice(_newDevice);
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('رمز با موفقیت تغییر یافت')));

                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('رمز قدیمی اشتباه وارد شده است.')));
                  }

                  Navigator.of(context).pop();
                },

              ),
              new FlatButton(
                child: new Text("انصراف"),
                onPressed: () {
                  Navigator.of(context).pop();
                },

              ),
            ],
        )
        );
      }
    );

  }

  //Device _dev= _db.getDevice(_deviceId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl, child:
    new FutureBuilder(
      future: _db.getDevice(_deviceId),
      builder: (BuildContext context,AsyncSnapshot<Device> snapshot){
        if (snapshot.hasData){
          String _password=snapshot.data.password;
          List<String> _Contactlist=[snapshot.data.simnumber];
          String _device_name= snapshot.data.title;
          return new Scaffold(
            appBar: new AppBar(
                title: new Text('$_device_name')
            ),
            body: new Container(
              padding: EdgeInsets.all(15.0),

              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: (){
                        _showDialog(_deviceId);
                       // Navigator.of(context).pop();
                      }

                      ,child: new Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.red,
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 3.0,
                          )
                        ),
                        //constraints: BoxConstraints.expand(),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Container(
                              child: new CircleAvatar(

                                child: new Icon(Icons.delete_forever,color: Colors.red,size: 28.0,),
                                minRadius: 26.0,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            new Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,

                              child: new Center(
                                //alignment: Alignment.center,
                                child: new Text('حذف دستگاه',textScaleFactor: 1.5,),
                                //width: 150.0,

                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    new Padding(padding: EdgeInsets.all(5.0)),

                    new GestureDetector(
                      onTap: (){
                        _showChangePassDialog(snapshot.data);
                      },

                      child: new Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.orangeAccent,
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 3.0,
                            )
                        ),
                        //constraints: BoxConstraints.expand(),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Container(
                              child: new CircleAvatar(

                                child: new Icon(Icons.screen_lock_rotation,color: Colors.orangeAccent,size: 28.0,),
                                minRadius: 26.0,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            new Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,


                              child: new Center(
                                //alignment: Alignment.center,
                                child: new Text('تغییر رمز دستگاه',textScaleFactor: 1.5,),
                                //width: 150.0,

                              ),
                            )

                          ],
                        ),
                      ),
                    ),


                  ],
                )
              )
            ),

          );


        }
      },

    )
    );
  }
}