import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/api/apiWorkbook.dart';
import 'package:untitled/screens/workbook_detail_screen.dart';

class WorkbookList extends StatelessWidget {
  const WorkbookList({Key key, this.workbooks}) : super(key: key);

  final List<Workbook> workbooks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: workbooks.length,
      itemBuilder: (context, index) {
        final item = workbooks[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  WorkbookDetailScreen(id: item.artlSeq, title: item.title)
              ));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: Colors.black12
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4
                ),
                child: Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.jmNm,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              item.title,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            )
                          ],
                        )
                    )
                )
            )
        );
      },
    );
  }
}