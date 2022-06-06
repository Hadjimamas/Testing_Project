import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:testing/home_page.dart';

void main() {
  runApp(const MyApp());
}

//flutter pub global run dcdg
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.black),
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: const Color(0xFF001A2A),
            shadowColor: Colors.cyanAccent,
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0x46072030),
          ),
          scaffoldBackgroundColor: const Color(0xFF001A2A),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 5,
            actionsIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xff014975),
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.greenAccent,
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}
