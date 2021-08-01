import 'package:flutter/material.dart';
import 'package:untitled/api/apiWorkbookDetail.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

final dio = new Dio();

void downloadFile(String uri, String fileName) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    print("${dir.path}/$fileName");
    await dio.download(
      uri,
      "${dir.path}/$fileName",
        onReceiveProgress: showDownloadProgress
    );
  } catch(e) {

  }
}

void showDownloadProgress(received, total) {
  if(total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

class WorkbookDetailList extends StatelessWidget {

  final List<WorkbookDetail> questionDetails;
  final String title;

  const WorkbookDetailList({
    Key key,
    this.questionDetails,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questionDetails.length,
      itemBuilder: (context, index) {
        final item = questionDetails[index];
        return GestureDetector(
          onTap: () {
            downloadFile(item.fileUrl, item.fileNm);
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
                            title,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            item.fileNm,
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      )
                  )
              )
          ),
        );
      },
    );
  }
}