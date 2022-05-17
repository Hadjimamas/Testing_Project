import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  ProjectInfoState createState() => ProjectInfoState();
}

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
    super.initState();
    initPackageInfo();
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

  int year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copyright ©$year, All Rights Reserved.Powered by:',
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  color: Colors.white),
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
              tooltip: 'Instagram',
              onPressed: () {
                launchUrlString(
                    'https://www.instagram.com/andreas_hadjimamas/');
              },
              icon: const Icon(Icons.install_desktop,
                  color: Colors.pinkAccent, size: 20.0),
            ),
            IconButton(
              tooltip: 'GitHub',
              onPressed: () {
                launchUrlString(
                    'https://www.instagram.com/andreas_hadjimamas/');
              },
              icon: const Icon(Icons.gite_outlined,
                  color: Colors.black, size: 20.0),
            ),
          ],
        ),
      ],
      appBar: AppBar(
        title: Text(packageInfo.appName),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          infoTile('App name', packageInfo.appName),
          infoTile('Package name', packageInfo.packageName),
          infoTile('App version', packageInfo.version),
          infoTile('Build number', packageInfo.buildNumber),
          infoTile('Build signature', packageInfo.buildSignature),
        ],
      ),
    );
  }
}
