// ignore_for_file: avoid_print

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult result = ConnectivityResult.none;
  bool hasInternet = false;
  Icon networkIcon = const Icon(Icons.wifi_off);
  Color color = Colors.red;
  String platformType = 'Other Platform';
  String msg = 'No Internet Connection';

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
      print('Other Platform');
    }
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() => this.result = result);
      if (result == ConnectivityResult.wifi) {
        msg = 'Wi-Fi Connection';
        networkIcon = const Icon(Icons.wifi);
        color = Colors.green;
      } else if (result == ConnectivityResult.ethernet) {
        msg = 'Ethernet Connection';
        networkIcon = const Icon(Icons.settings_ethernet);
        color = Colors.green;
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
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Network Status"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$platformType Platform'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                networkIcon,
                Text(msg),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
