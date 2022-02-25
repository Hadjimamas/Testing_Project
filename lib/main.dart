import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:testing/Widget.dart';

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

  //List<Map<FixturesData, dynamic>> foundMatches = [];

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
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
        search((value) => _runFilter(value), editingController),
        //Search
        /*
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            controller: editingController,
            decoration: const InputDecoration(

                /// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685

                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),*/
        Text("Current Time and Date: $_timeString"),
        Text("You have selected: $dateNow"),
        //print(_foundUsers.length);
        Text(_allUsers.length.toString()),
        Text(_foundUsers.length.toString()),

        Expanded(
          child: _foundUsers.isNotEmpty
              ? ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_foundUsers[index]["id"]),
                    color: Colors.amberAccent,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Text(
                        _foundUsers[index]["id"].toString(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(_foundUsers[index]['name']),
                      subtitle: Text(
                          '${_foundUsers[index]["age"].toString()} years old'),
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
        //Text("${selectedDate.toLocal()}".split(' ')[0]),
        //print(listScore.where((score) => score > 1).toList());
      ],
    );
  }
}
