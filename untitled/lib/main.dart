import 'package:flutter/material.dart';
import 'package:untitled/components/checkBox.dart';
import 'package:untitled/screens/search_screen.dart';
import 'package:untitled/api/apiLicenseList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future _futureLicense;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    this._futureLicense = apiLicenseList();
    return MaterialApp(
      title: 'relay7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder(
        future: this._futureLicense,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final licenses = snapshot.data;
            final licenseList = licenses.map((v)=>v['value']).toList();
            return SearchScreen(myList: List.generate(licenseList.length, (int index) {
              return MyCheckBox(title: licenseList[index]);
            }));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}