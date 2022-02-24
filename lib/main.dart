import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:intl/intl.dart';

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
              ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  late String _timeString;
  DateTime selectedDate = DateTime.now();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
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
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(dateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //DateFormat formatterDate = DateFormat('dd/MM/yyyy');
    String dateNow = _formatDateTime(selectedDate);
    return Column(
      children: [
        AppBar(
          title: Text(
            'Example Project',
            style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(
                  color: Colors.white, letterSpacing: .5, fontSize: 30),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: const Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.live_tv_rounded,
                color: Colors.lightGreenAccent,
              ),
              onPressed: () {
                modalBottomSheet(context);
              },
            ),
          ],
        ),
        //Search
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: editingController,
            decoration: const InputDecoration(

                ///https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685

                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        //Text("${selectedDate.toLocal()}".split(' ')[0]),
        Text("Current Time and Date: $_timeString"),
        Text("You have selected: $dateNow"),
        //print(listScore.where((score) => score > 1).toList());
      ],
    );
  }
}
