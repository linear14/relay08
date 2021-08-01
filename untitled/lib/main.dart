import 'package:flutter/material.dart';
import 'package:untitled/components/checkBox.dart';
import 'package:untitled/screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var licenseList = ["가스기술사","건설기계기술사","건축구조기술사","공인노무사","산업보건지도사"];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'relay7',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SearchScreen(myList: List.generate(licenseList.length, (int index) {
          return MyCheckBox(title: licenseList[index]);
        }))
    );
  }
}
