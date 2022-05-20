import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:testing/email.dart';
import 'package:testing/package_info.dart';
import 'package:testing/widget.dart';

void main() {
  runApp(const MyApp());
}

///Check the type of the device to add the correct adUnit for every OS(ex.android,iOS);
class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

ScrollController listScrollController = ScrollController();

//flutter pub global run dcdg
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => OverlaySupport.global(
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF001A2A), centerTitle: true),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: const Color(0xff22215B),
                  displayColor: const Color(0xff22215B),
                ),
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xE2334753),
              onPressed: () {
                Clipboard.setData(
                        const ClipboardData(text: "Text you want to copy here"))
                    .then((_) {
                  toast('Text Copied');
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text('Copied to your clipboard !')));
                });
                // Clipboard.setData(const ClipboardData(text: "your text"));
                if (listScrollController.hasClients) {
                  final position =
                      listScrollController.position.maxScrollExtent;
                  listScrollController.animateTo(
                    position,
                    duration: const Duration(seconds: 3),
                    curve: Curves.easeOut,
                  );
                }
              },
              isExtended: true,
              tooltip: 'Scroll to Bottom',
              child: const Icon(Icons.arrow_downward),
            ),
            body: const MyHomePage(),
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

DateTime selectedDate = DateTime.now();

class MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caver-sky", "age": 47},
    {"id": 10, "name": "Becky", "age": 32},
  ];
  List<Map<String, dynamic>> _foundUsers = [];

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user['name'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      //we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(
      () {
        _foundUsers = results;
      },
    );
  }

  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      keyboardType: TextInputType.datetime,
      builder: (context, child) {
        ///Change the design of the date
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff014975), //Header background color
              onPrimary: Colors.white, //Header text color
              onSurface: Colors.black, //Text color of the dates
            ),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black, //Text color of the input date
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: const Color(0xff014975), //Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        modalBottomSheet(context);
      });
      showSimpleNotification(Text('Date Selected ${formatDateTime(picked)}'),
          leading: const Icon(Icons.event_available_outlined),
          background: Colors.green,
          position: NotificationPosition.top,
          slideDismissDirection: DismissDirection.up);
    } else {
      showSimpleNotification(const Text('No Date Selected'),
          leading: const Icon(Icons.event_busy_outlined),
          background: Colors.red,
          position: NotificationPosition.bottom,
          slideDismissDirection: DismissDirection.up);
    }
  }

  @override
  Widget build(BuildContext context) {
    String newDate = formatDateTime(selectedDate);
    String allUsers = _allUsers.length.toString();
    String foundUsers = _foundUsers.length.toString();
    return Column(
      children: [
        AppBar(
          title: Text(
            'Example Project',
            style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(
                color: Colors.white,
                letterSpacing: .5,
                fontSize: 30,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'Project Info',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectInfo()),
                );
              },
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
            IconButton(
              tooltip: 'Date Picker',
              onPressed: () {
                selectDate(context);
              },
              icon: const Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ),
            IconButton(
              tooltip: 'Bottom Sheet',
              icon: const Icon(
                Icons.stadium_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                selectedDate = DateTime.now();
                modalBottomSheet(context);
              },
            ),
            IconButton(
              tooltip: 'Contact Developer',
              icon: const Icon(
                Icons.contact_mail_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailSender()),
                );
              },
            ),
          ],
        ),
        search((value) => runFilter(value), editingController),
        Text('You have selected: $newDate'),
        Text('Results: $foundUsers/$allUsers'),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        checkNetworkConnection();
                      },
                      tooltip: 'Check Internet Connection',
                      icon: const Icon(
                        Icons.network_check,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/GIF_Test.gif',
                        ),
                        title: const Text(
                          'Sample Text',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        controller: listScrollController,
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundUsers[index]['id']),
                          color: Colors.amberAccent,
                          elevation: 20,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Text(
                              '${index + 1}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(_foundUsers[index]['name']),
                            subtitle: Text(
                                '${_foundUsers[index]['age'].toString()} years old'),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No results found!',
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
