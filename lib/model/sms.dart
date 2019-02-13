import 'package:simple_sms/simple_sms.dart';
import 'package:flutter/services.dart';

class SMS {
  List<String> _contacts=[];
  String _messageBody='';

  void SendSms(List<String> Contact_list,String MessageBody) async{
    final SimpleSms simpleSms = SimpleSms();
    simpleSms.sendSms(Contact_list, MessageBody);

  }
}