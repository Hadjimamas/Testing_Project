import 'package:flutter/material.dart';

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
