// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:testing/main.dart';

Widget search(
    void Function(String) onChanged, TextEditingController editingController) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
      onChanged: onChanged,
      controller: editingController,
      decoration: const InputDecoration(
        labelText: 'Search',
        hintText: 'Search Name',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    ),
  );
}

DateTime now = DateTime.now();
final DateFormat formatterDate = DateFormat('dd/MM/yyyy');

Future<void> modalBottomSheet(BuildContext context) {
  String? platformType;
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
  return showModalBottomSheet<void>(
    //enableDrag: false,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$platformType Platform \n $selectedDate',
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 10, right: 30, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          //Text('Close BottomSheet'),
                          Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      onPressed: () => {Navigator.pop(context)},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 5,
                              style: BorderStyle.solid),
                        ),
                        primary: Colors.black38,
                        //Below is the colour of the button when you press it
                        onPrimary: Colors.red,
                        //side: const BorderSide(color: Colors.red, width: 2),
                        alignment: Alignment.center,
                        elevation: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future checkNetworkConnection() async {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  hasInternet = await InternetConnectionChecker().hasConnection;
  result = await Connectivity().checkConnectivity();
  Icon connectivityIcon;
  final color = hasInternet ? Colors.green : Colors.red;
  String connectionType;
  final connectionMsg =
      hasInternet ? 'Internet Connection Success' : 'No Internet Connection';
  if (result == ConnectivityResult.mobile) {
    connectionType = 'Mobile Data';
    connectivityIcon = const Icon(Icons.swap_vert);
  } else if (result == ConnectivityResult.wifi) {
    connectionType = 'Wi-Fi';
    connectivityIcon = const Icon(Icons.wifi);
  } else if (result == ConnectivityResult.ethernet) {
    connectionType = 'Ethernet Connection';
    connectivityIcon = const Icon(Icons.settings_ethernet);
  } else {
    connectionType = 'Unknown Type';
    connectivityIcon = const Icon(Icons.signal_wifi_off);
  }
  showSimpleNotification(
    ListTile(
      leading: connectivityIcon,
      title: Text(connectionMsg),
    ),
    subtitle: Text('Connected with: $connectionType'),
    duration: const Duration(seconds: 3),
    slideDismissDirection: DismissDirection.up,
    background: color,
  );
  print('Internet Connection: $hasInternet\nConnection Type: $result');
}
