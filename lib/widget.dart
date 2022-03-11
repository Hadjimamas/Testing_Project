import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

Widget search(
    void Function(String) onChanged, TextEditingController editingController) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
      onChanged: onChanged,
      controller: editingController,
      decoration: const InputDecoration(

          /// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685

          labelText: "Widget Search",
          hintText: "Widget Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    ),
  );
}

Future<void> modalBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
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
                'This is the BottomSheet',
                style: GoogleFonts.dancingScript(
                  textStyle:
                      const TextStyle(color: Colors.white, letterSpacing: .5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, right: 30, bottom: 20),
                child: ElevatedButton(
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
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 50),
                    shape: const CircleBorder(),
                    primary: Colors.black38,
                    //Below is the colour of the button when you press it
                    onPrimary: Colors.red,
                    side: const BorderSide(color: Colors.red, width: 2),
                    alignment: Alignment.center,
                    elevation: 2,
                  ),
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
  Icon connectivityIcon = const Icon(Icons.signal_wifi_off);
  final color = hasInternet ? Colors.green : Colors.red;
  String connectionType = 'Unknown Type';
  final connectionMsg =
      hasInternet ? 'Internet Connection Success' : 'No Internet Connection';
  if (result == ConnectivityResult.mobile) {
    connectionType = 'Mobile Data';
    connectivityIcon = const Icon(Icons.swap_vert);
  } else if (result == ConnectivityResult.wifi) {
    connectionType = 'Wifi';
    connectivityIcon = const Icon(Icons.wifi);
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
}
