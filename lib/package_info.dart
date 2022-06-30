// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:testing/widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  ProjectInfoState createState() => ProjectInfoState();
}

ConnectivityResult result = ConnectivityResult.none;
Color color = Colors.red;
Icon networkIcon = const Icon(
  Icons.wifi_off,
  color: Colors.red,
);
String platformType = 'Other Platform';
String msg = 'No Internet Connection';

class ProjectInfoState extends State<ProjectInfo> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    if (Platform.isAndroid) {
      platformType = 'Android';
    } else if (Platform.isIOS) {
      platformType = 'iOS';
    } else if (Platform.isWindows) {
      platformType = 'Windows';
    } else {
      platformType = 'Other Platform';
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
      } else if (newResult == ConnectivityResult.mobile) {
        msg = 'Mobile Data Connection';
        color = Colors.green;
        networkIcon = Icon(
          Icons.swap_vert,
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
    initPackageInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Widget infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copyright ©${DateTime.now().year}, All Rights Reserved. Powered by:',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: 'Facebook',
              onPressed: () {
                launchUrlString('https://www.facebook.com/andreas.hadjimamas/');
              },
              icon: const Icon(Icons.facebook, color: Colors.blue, size: 20.0),
            ),
            IconButton(
              tooltip: 'E-mail',
              onPressed: () {
                Clipboard.setData(const ClipboardData(
                        text: 'andreashadjimama@hotmail.com'))
                    .then((_) {
                  showSimpleNotification(
                      const Text('E-mail Copied to Clipboard'),
                      leading: const Icon(Icons.copy_rounded),
                      background: Colors.blueGrey,
                      position: NotificationPosition.top,
                      slideDismissDirection: DismissDirection.up);
                });
              },
              icon: const Icon(Icons.email_outlined,
                  color: Colors.teal, size: 20.0),
            ),
            const FlutterLogo(
              textColor: Colors.white,
              style: FlutterLogoStyle.horizontal,
              size: 50,
            ),
          ],
        ),
      ],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  checkNetworkConnection();
                },
                tooltip: 'Connectivity Test',
                icon: const Icon(
                  Icons.network_check,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          //Text('$platformType Platform'),
          ListTile(
            onTap: () {
              checkNetworkConnection();
            },
            leading: networkIcon,
            title: Text(msg),
            subtitle: Text('$platformType Platform'),
          ),
          infoTile('App Name', packageInfo.appName),
          infoTile('Package Name', packageInfo.packageName),
          infoTile('App Version', packageInfo.version),
          infoTile('Build Number', packageInfo.buildNumber),
          infoTile('Build Signature', packageInfo.buildSignature),
        ],
      ),
    );
  }
}
