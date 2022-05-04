import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProjectInfoPage(),
    );
  }
}

class ProjectInfoPage extends StatelessWidget {
  const ProjectInfoPage({Key? key}) : super(key: key);

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Info'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<PackageInfo>(
          future: _getPackageInfo(),
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
