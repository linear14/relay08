import 'package:flutter/material.dart';
import 'package:untitled/api/apiWorkbookDetail.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/components/WorkbookDetailList.dart';

class WorkbookDetailScreen extends StatelessWidget {

  final String id;
  final String title;

  const WorkbookDetailScreen({
    this.id,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: FutureBuilder<List<WorkbookDetail>>(
          future: fetchDetails(http.Client(), id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return WorkbookDetailList(
                  questionDetails: snapshot.data, title: title);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
    );
  }
}