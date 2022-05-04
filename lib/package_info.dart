import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  ProjectInfoState createState() => ProjectInfoState();
}

class ProjectInfoState extends State<ProjectInfo> {
  Future<PackageInfo> getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Copyright ©2020, All Rights Reserved.',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  color: Color(0xFF162A49)),
            ),
            const Text(
              'Powered by:',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  color: Color(0xFF162A49)),
            ),
            IconButton(
              alignment: Alignment.center,
              tooltip: 'GitHub',
              onPressed: () {
                launchUrlString('https://github.com/Hadjimamas');
              },
              icon: const Icon(
                Icons.sports_soccer,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
      appBar: AppBar(
        title: const Text('Project Info'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<PackageInfo>(
          future: getPackageInfo(),
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            if (snapshot.hasError) {
              return const Text('ERROR');
            } else if (!snapshot.hasData) {
              return const Text('Loading...');
            }

            final data = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'App Name: ${data.appName} \n Package Name: ${data.packageName} \n Version: ${data.version} \n Build Number: ${data.buildNumber}',
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
