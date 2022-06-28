// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:testing/widget.dart';

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  EmailSenderState createState() => EmailSenderState();
}

class EmailSenderState extends State<EmailSender> {
  bool useTempDirectory = true;
  List<String> attachment = <String>[];
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> send(BuildContext context) async {
    if (Platform.isIOS) {
      final bool canSend = await FlutterMailer.canSendMail();
      if (!canSend) {
        const SnackBar snackBar =
            SnackBar(content: Text('No Email App Available'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    final MailOptions mailOptions = MailOptions(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: <String>['example@example.com'],
      isHTML: true,
      // bccRecipients: ['other@example.com'],
      ccRecipients: <String>['third@example.com'],
      attachments: attachment,
    );

    String platformResponse;

    try {
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      switch (response) {
        case MailerResponse.saved:
          platformResponse = 'Email was saved to draft';
          break;
        case MailerResponse.sent:
          platformResponse = 'Email was sent';
          break;
        case MailerResponse.cancelled:
          platformResponse = 'Email was cancelled';
          break;
        case MailerResponse.android:
          platformResponse = 'Intent was success';
          break;
        default:
          platformResponse = 'Unknown';
          break;
      }
    } on PlatformException catch (error) {
      platformResponse = error.toString();
      print(error);
      if (!mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Message',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(error.message ?? 'Unknown error'),
            ],
          ),
          contentPadding: const EdgeInsets.all(26),
          title: Text(error.code),
        ),
      );
    } catch (error) {
      platformResponse = error.toString();
    }
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: IconButton(
          onPressed: () => send(context),
          icon: const Icon(Icons.send, color: Colors.white)),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: inputDecoration('Subject', ''),
                    controller: _subjectController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: inputDecoration('Body', ''),
                    controller: _bodyController,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
