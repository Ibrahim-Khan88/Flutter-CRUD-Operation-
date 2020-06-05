import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectdemo/ShowList/ShowList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Test app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentList(),

    );
  }

}
