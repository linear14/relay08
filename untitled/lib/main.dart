import 'package:flutter/material.dart';
import 'package:untitled/components/checkBox.dart';
import 'package:untitled/screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var licenseList = ["자격증1","자격증2","자격증3","자격증4","자격증5"];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SearchScreen(myList: List.generate(licenseList.length, (int index) {
          return MyCheckBox(title: licenseList[index]);
        }))
    );
  }
}
