// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:testing/network.dart';
import 'package:testing/widget.dart';

void main() {
  runApp(const MyApp());
}

//flutter pub global run dcdg
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: MyHomePage(),
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


  late String _timeString;
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
    {"id": 9, "name": "Caver-sky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];
  List<Map<String, dynamic>> _foundUsers = [];

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
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
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getTime(DateTime.now()));
    super.initState();
  }

  void _getTime(DateTime now) {
    final String formattedDateTime = _formatDateTime(now);
    setState(
      () {
        _timeString = formattedDateTime;
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
    //hh:mm:ss
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        modalBottomSheet(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
    String newDate = _formatDateTime(selectedDate);
    String allUsers = _allUsers.length.toString();
    String foundUsers = _foundUsers.length.toString();
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: const Color(0xE2334753),
          onPressed: () {
            if (listScrollController.hasClients) {
              final position = listScrollController.position.maxScrollExtent;
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
          centerTitle: true,
          actions: <Widget>[
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
                modalBottomSheet(context);
              },
            ),
            IconButton(
              tooltip: 'Troubleshot',
              icon: const Icon(
                Icons.perm_data_setting,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Troubleshoot()),
                );
              },
            ),
          ],
        ),
        search((value) => runFilter(value), editingController),
        Text('Current Time and Date: $_timeString'),
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
                    ElevatedButton(
                      onPressed: () {
                        checkNetworkConnection();
                      },
                      child: const Text('Check Internet Connection'),
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
                              _foundUsers[index]['id'].toString(),
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
