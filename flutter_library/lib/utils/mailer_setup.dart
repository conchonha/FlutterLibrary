import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailerSetup{
  static Future<int> setup(String email,BuildContext context) async{
    String username = 'thaibasang08081999@gmail.com';
    String password = 'nguyenthinguyetminh1402200008081999';
    int number = Random().nextInt(100000);

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(email)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
     // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Please enter this code in the box to confirm your email :: 😀 :: ${DateTime.now()}'
      ..text = '$number';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
//      for (var p in e.problems) {
//        print('Problem: ${p.code}: ${p.msg}');
//      }
    }
    return number;
  }
}