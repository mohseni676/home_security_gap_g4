class Device {
  int _id;
  String _title;
  String _simnumber;
  String _password;

  Device(this._title, this._simnumber,this._password);

  Device.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._simnumber = obj['simnumber'];
    this._password=obj['password'];

  }

  int get id => _id;
  String get title => _title;
  String get simnumber => _simnumber;
  String get password =>_password;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['simnumber'] = _simnumber;
    map['password'] = _password;

    return map;
  }

  Device.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._simnumber = map['simnumber'];
    this._password=map['password'];
  }
}