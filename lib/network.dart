// ignore_for_file: avoid_print

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Troubleshoot extends StatefulWidget {
  const Troubleshoot({Key? key}) : super(key: key);

  @override
  _TroubleshootState createState() => _TroubleshootState();
}

late StreamSubscription<ConnectivityResult> _connectivitySubscription;
ConnectivityResult result = ConnectivityResult.none;
Color color = Colors.red;
Icon networkIcon = const Icon(
  Icons.wifi_off,
  color: Colors.red,
);
String platformType = 'Other Platform';
String msg = 'No Internet Connection';

class _TroubleshootState extends State<Troubleshoot> {
  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      platformType = 'Android';
      print('Android');
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      platformType = 'iOS';
      print('iOS');
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      platformType = 'Windows';
      print('Windows');
    } else {
      platformType = 'Other Platform';
      print('Other Platform');
    }
    Connectivity().onConnectivityChanged.listen((newResult) {
      setState(() => result = newResult);
      if (newResult == ConnectivityResult.wifi) {
        msg = 'Wi-Fi Connection';
        color = Colors.green;
        networkIcon = Icon(
          Icons.wifi,
          color: color,
        );
      } else if (newResult == ConnectivityResult.ethernet) {
        msg = 'Ethernet Connection';
        color = Colors.green;
        networkIcon = Icon(
          Icons.settings_ethernet,
          color: color,
        );
      } else {
        msg = 'No Internet Connection';
        color = Colors.red;
        networkIcon = Icon(
          Icons.wifi_off,
          color: color,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Network Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$platformType Platform'),
            ListTile(
              leading: networkIcon,
              title: Text(msg),
            ),
          ],
        ),
      ),
    );
  }
}
